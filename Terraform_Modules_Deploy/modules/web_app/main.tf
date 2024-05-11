# Get the Latest Amazon Linux AMI
data "aws_ami" "Ubuntu_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  owners = ["amazon"]
}

# IAM Role for EC2 Instances
resource "aws_iam_role" "Terraform_Ssm_Role" {
  name = "Terraform_Ssm_Role"

  assume_role_policy = <<-EOF
    {
      "Version":"2012-10-17",
      "Statement":[
        {
          "Effect":"Allow",
          "Principal": {
            "Service": [
              "ec2.amazonaws.com"
            ]
          },
          "Action":"sts:AssumeRole"
        }
      ]
    }
  EOF
}

# IAM Instance Profile with the Role
resource "aws_iam_instance_profile" "Terraform_Ssm_Role" {
  name = "Terraform_Ssm_Role"
  role = aws_iam_role.Terraform_Ssm_Role.name
}

# Attach AdministratorAccess managed policy to the IAM role
resource "aws_iam_role_policy_attachment" "AdministratorAccessAttachment" {
  role       = aws_iam_role.Terraform_Ssm_Role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Application Load Balancer
resource "aws_lb" "webapp_lb" {
  name               = "webapp-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.load_balancer_sg_id]
  subnets            = var.public_subnet_ids
  enable_deletion_protection = false

  tags = {
    Name = "webapp-lb"
  }
}

# Target Group
resource "aws_lb_target_group" "webapp_target_group" {
  name        = "webapp-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = 80
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 10
    interval            = 30
    matcher             = "200-399"
  }
  tags = {
    Name = "webapp-tg"
  }
}

# Application Load Balancer Listener
resource "aws_lb_listener" "webapp_lb_listener" {
  load_balancer_arn = aws_lb.webapp_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp_target_group.arn
  }
}

// create a launch template for the web app
resource "aws_launch_template" "webapp_lt" {
  name_prefix             = "webapp-lt-"
  instance_type           = var.instance_type
  image_id                = data.aws_ami.Ubuntu_ami.id
  key_name                = var.key_name
  user_data               = base64encode(file("${path.module}/user_data.sh"))
  
  network_interfaces {
    device_index        = 0
    subnet_id           = var.public_subnet_ids[0] 
    security_groups     = [var.webapp_sg_id]
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.Terraform_Ssm_Role.name
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "webapp"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "webapp_asg" {
  name_prefix                      = "WebAppASG-"
  launch_template {
    id      = aws_launch_template.webapp_lt.id
    version = "$Latest"
  }
  vpc_zone_identifier       = var.webapp_subnet_ids
  target_group_arns         = [aws_lb_target_group.webapp_target_group.arn] // target group doesn't exist yet, so using variable will return nothing, input directly the value
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  termination_policies      = ["OldestInstance"]
  force_delete              = true

  depends_on = [
    aws_lb_target_group.webapp_target_group,
    aws_lb_listener.webapp_lb_listener
  ]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "WebAppASG"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "webapp_asg_attachment" {
  count                  = length(var.webapp_subnet_ids)
  autoscaling_group_name = aws_autoscaling_group.webapp_asg.name
  lb_target_group_arn    = aws_lb_target_group.webapp_target_group.arn
}

# Auto Scaling Policies
resource "aws_autoscaling_policy" "scaling_out_policy" {
  name                   = "cpu-scaling-out"
  autoscaling_group_name = aws_autoscaling_group.webapp_asg.name // directly reference it to avoid the unmatching name with auto scaling group
  adjustment_type        = "PercentChangeInCapacity"
  scaling_adjustment     = 25
  cooldown               = 300
  policy_type            = "SimpleScaling"
}

resource "aws_autoscaling_policy" "scaling_in_policy" {
  name                   = "cpu-scaling-in"
  autoscaling_group_name = aws_autoscaling_group.webapp_asg.name // directly reference it to avoid the unmatching name with auto scaling group
  adjustment_type        = "PercentChangeInCapacity"
  scaling_adjustment     = -25
  cooldown               = 300
  policy_type            = "SimpleScaling"
}

# SNS Topic for Scaling Notifications
resource "aws_sns_topic" "asg_sns_topic" {
  name = "asg-scaling-notifications"
}

# Subscription for Scaling Notifications Email
resource "aws_sns_topic_subscription" "asg_sns_subscription" {
  topic_arn  = aws_sns_topic.asg_sns_topic.arn
  protocol   = "email"
  endpoint   = var.operator_email
}

# CloudWatch Alarms for Scaling
resource "aws_cloudwatch_metric_alarm" "cpu_scale_out_alarm" {
  alarm_name          = "CpuUtilizationAlarm"
  alarm_description   = "Alarm to scale out web servers based on CPU"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 30
  statistic           = "Average"
  threshold           = 40
  alarm_actions       = [aws_autoscaling_policy.scaling_out_policy.arn]
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "cpu_scale_in_alarm" {
  alarm_name          = "LowCpuUtilizationAlarm"
  alarm_description   = "Alarm to scale in web servers based on CPU"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 30
  statistic           = "Average"
  threshold           = 40
  alarm_actions       = [aws_autoscaling_policy.scaling_in_policy.arn]
  treat_missing_data  = "missing"
}