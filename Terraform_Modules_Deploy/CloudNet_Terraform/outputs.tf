<<<<<<< HEAD

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
=======
# output "vpc_id" {
#   value = aws_vpc.terra_vpc.id
# }

# output "public_subnet_ids" {
#   value = [
#     aws_subnet.terra_pub_sub1.id,
#     aws_subnet.terra_pub_sub2.id
#   ]
# }

# output "private_subnet_ids" {
#   value = [
#     aws_subnet.terra_priv_sub1.id,
#     aws_subnet.terra_priv_sub2.id,
#     aws_subnet.terra_priv_sub3.id,
#     aws_subnet.terra_priv_sub4.id
#   ]
# }

# output "internet_gateway_id" {
#   value = aws_internet_gateway.terra_igw.id
# }

# output "nat_gateway_id" {
#   value = aws_nat_gateway.nat_gateway.id
# }

# output "public_route_table_id" {
#   value = aws_route_table.pub_terra_rt.id
# }

# output "private_route_table_id" {
#   value = aws_route_table.priv_terra_rt.id
# }
>>>>>>> 6fc70ed423ad9265eec9df1092eec5a0f3de8117
