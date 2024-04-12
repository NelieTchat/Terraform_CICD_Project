output "load_balancer_dns_name" {
  value = aws_lb.webapp_load_balancer.dns_name
}
output "lt_image_id" {
  value = data.aws_ami.Linux_ami.id
}
