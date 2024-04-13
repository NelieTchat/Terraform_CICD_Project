output "load_balancer_sg_id" {
  value = module.networking.load_balancer_sg_id
}

output "webapp_sg_id" {
  value = module.networking.webapp_sg_id
}

output "db_sg_id" {
  value = module.networking.db_sg_id
}

output "public_subnet_cidr_blocks" {
  value = module.networking.public_subnet_cidr_blocks
}

output "private_subnet_cidr_blocks" {
  value = module.networking.private_subnet_cidr_blocks
}

output "nat_gateway_eip" {
  value = module.networking.nat_gateway_eip
}
output "load_balancer_dns_name" {
  value = module.web_app.load_balancer_dns_name
}


