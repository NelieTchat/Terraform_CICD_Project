output "public_subnet_ids" {
  value = [for key, subnet in aws_subnet.terra-pub-sub : subnet.id]
}

output "private_subnet_ids" {
  value = [for key, subnet in aws_subnet.terra-priv-sub : subnet.id]
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_cidr_blocks" {
  value = { for key, subnet in aws_subnet.terra-pub-sub : key => subnet.cidr_block }
}

output "private_subnet_cidr_blocks" {
  value = { for key, subnet in aws_subnet.terra-priv-sub : key => subnet.cidr_block }
}
output "nat_gateway_eip" {
  value = aws_eip.nat_eip.id
}
output "load_balancer_sg_id" {
  value = aws_security_group.load_balancer_sg.id
}

output "webapp_sg_id" {
  value = aws_security_group.webapp_sg.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}
