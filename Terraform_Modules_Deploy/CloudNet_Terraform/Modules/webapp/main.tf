# Define Load Balancer
resource "aws_lb" "load_balancer" {
  name               = "loadBalancer"
  subnets            = [
    module.networking.public_subnet1_ids
  
  ]
  security_groups    = [module.networking.load_balancer_security_group_id]
  scheme             = "internet-facing"
  load_balancer_type = "application"
  ip_address_type    = "ipv4"

  tags = {
    Name = "DevLoadBalancer"
  }
}
# Define Load Balancer Listener
resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
# Define Target Group
resource "aws_lb_target_group" "target_group" {
  name                       = "TargetGroup"
  port                       = 80
  protocol                   = "HTTP"
  target_type                = "instance"
  vpc_id                     = module.networking.vpc_id
  health_check_interval      = 10
  health_check_path          = "/"
  health_check_protocol      = "HTTP"
  health_check_timeout       = 5
  healthy_threshold          = 2
  unhealthy_threshold        = 2
}
