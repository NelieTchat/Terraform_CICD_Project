# Outputs
output "webapp_lb_dns_name" {
  value = aws_lb.webapp_lb.dns_name
}

output "image_id"{
  value = data.aws_ami.Ubuntu_ami.id
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.webapp_target_group.arn
}
