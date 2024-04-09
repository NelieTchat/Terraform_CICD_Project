# Create an Application Load Balancer
# resource "aws_lb" "load_balancer" {
#   name               = "WebAppLoadBalancer"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [var.networking.load_balancer_sg_id]
#   subnets            = var.networking.public_subnet_ids
# }

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
  }

  tags = {
    Name = "webapp-target-group"
  }
}

# Create a launch template for the web application
resource "aws_launch_template" "webapp_lt" {
  name = "WebAppLaunchTemplate"

  instance_type           = var.lt_instance_type
  image_id                = var.lt_image_id
  vpc_security_group_ids  = [var.webapp_sg_id]

  iam_instance_profile {
    name = var.lt_iam_instance_profile
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
  min_size             = var.lt_min_size
  max_size             = var.lt_max_size
  desired_capacity     = var.lt_desired_capacity
  target_group_arns    = [var.lt_target_group_arn]
  vpc_zone_identifier  = var.lt_subnets
  health_check_type    = var.lt_health_check_type
  health_check_grace_period = var.lt_health_check_grace_period


}
