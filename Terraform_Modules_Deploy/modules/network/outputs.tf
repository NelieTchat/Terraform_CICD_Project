# Outputs
output "vpc_id" {
  value = aws_vpc.MyVpc.id
}

output "public_subnet_ids" {
    value = aws_subnet.public-subnets[*].id
}

output "webapp_subnet_ids" {
  value = aws_subnet.webapp-subnets[*].id
}

output "db_subnet_ids" {
  value = aws_subnet.db-subnets[*].id
}

output "public_route_table_id" {
  value = aws_route_table.public-route-table.id
}

output "public_subnet_association_ids" {
  value = aws_route_table_association.public-subnet-association[*].id
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