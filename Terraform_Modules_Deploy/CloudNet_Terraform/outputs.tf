
output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
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
