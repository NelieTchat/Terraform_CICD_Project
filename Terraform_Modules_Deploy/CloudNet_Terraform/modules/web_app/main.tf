data "aws_ami" "Linux_ami" {
  most_recent = true
  filter { #filter is a dictionary. The filter will go in AWS and fetch the latest ami. AWs 
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  owners = ["amazon"]
}

resource "aws_lb" "webapp_load_balancer" {
  name               = "webapp-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.load_balancer_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "WebAppLoadBalancer"
  }
}

resource "aws_lb_target_group" "webapp_target_group" {
  name     = "webapp-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol               = "HTTP"
    port                   = 80
    path                   = "/"
    healthy_threshold      = 2
    unhealthy_threshold    = 2
    timeout                = 3
    interval               = 30
    matcher                = 200
  }

  tags = {
    Name = "webapp-target-group"
  }
}

resource "aws_lb_listener" "webapp_listener" {
  load_balancer_arn = aws_lb.webapp_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp_target_group.arn
  }
}

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

resource "aws_iam_instance_profile" "Terraform_Ssm_Role" {
  name = "Terraform_Ssm_Role"
  role = aws_iam_role.Terraform_Ssm_Role.name
}

# Attach AdministratorAccess managed policy to the IAM role
resource "aws_iam_role_policy_attachment" "AdministratorAccessAttachment" {
  role       = aws_iam_role.Terraform_Ssm_Role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create a launch template for the web application
resource "aws_launch_template" "webapp_lt" {
  name = "WebAppLaunchTemplate"

  instance_type           = var.lt_instance_type
  image_id               = data.aws_ami.Linux_ami.id
  key_name                = var.lt_key_pair  

  network_interfaces {
    device_index    = 0
    security_groups = [var.webapp_sg_id]
  }
  
  user_data               = base64encode(file("${path.module}/user_data.sh"))

  iam_instance_profile {
    name = aws_iam_instance_profile.Terraform_Ssm_Role.name
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "WebAppInstance"
    }
  }
}

# Create an Auto Scaling Group with the launch template
resource "aws_autoscaling_group" "webapp_asg" {
  name = "WebAppASG"
  
  min_size                    = var.lt_min_size
  max_size                    = var.lt_max_size
  desired_capacity            = var.lt_desired_capacity
  target_group_arns           = [var.lt_target_group_arn]
  vpc_zone_identifier         = var.public_subnet_ids
  health_check_type           = var.lt_health_check_type
  health_check_grace_period   = var.lt_health_check_grace_period

  launch_template {
    id = aws_launch_template.webapp_lt.id
    version = aws_launch_template.webapp_lt.latest_version
  }
}
