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
}
