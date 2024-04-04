<<<<<<< HEAD
output "public_subnet_ids" {
  value = [for key, subnet in aws_subnet.terra-pub-sub : subnet.id]
}

output "private_subnet_ids" {
  value = [for key, subnet in aws_subnet.terra-priv-sub : subnet.id]
}

output "public_subnet_cidr_blocks" {
  value = { for key, subnet in aws_subnet.terra-pub-sub : key => subnet.cidr_block }
}

output "private_subnet_cidr_blocks" {
  value = { for key, subnet in aws_subnet.terra-priv-sub : key => subnet.cidr_block }
}

output "nat_gateway_eip" {
  value = aws_eip.nat_eip.id
=======
# modules/network/outputs.tf

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = concat(
    [for s in aws_subnet.terra_pub_sub1 : s.id],
    [for s in aws_subnet.terra_pub_sub2 : s.id]
  )
}

output "private_subnet_ids" {
  value = concat(
    [for s in aws_subnet.terra_priv_sub1 : s.id],
    [for s in aws_subnet.terra_priv_sub2 : s.id],
    [for s in aws_subnet.terra_priv_sub3 : s.id],
    [for s in aws_subnet.terra_priv_sub4 : s.id]
  )
}

output "list_of_az" {
  value = data.aws_availability_zones.available[*].names
}

output "internet_gateway_id" {
  value = aws_internet_gateway.terra_igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.id
}

output "public_route_table_id" {
  value = aws_route_table.pub_terra_rt.id
}

output "private_route_table_id" {
  value = aws_route_table.priv_terra_rt.id
>>>>>>> 6fc70ed423ad9265eec9df1092eec5a0f3de8117
}
