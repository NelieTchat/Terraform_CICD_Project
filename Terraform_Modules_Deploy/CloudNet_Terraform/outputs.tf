#outputs
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet1_id" {
  value = aws_subnet.public_subnet1.id
}

output "public_subnet2_id" {
  value = aws_subnet.public_subnet2.id
}

output "private_subnet1_id" {
  value = aws_subnet.private_subnet1.id
}

output "private_subnet2_id" {
  value = aws_subnet.private_subnet2.id
}

output "private_subnet3_id" {
  value = aws_subnet.private_subnet3.id
}

output "private_subnet4_id" {
  value = aws_subnet.private_subnet4.id
}

output "nat_gateway_public_ip" {
  value = aws_nat_gateway.nat_gateway.public_ip
}


# output "Instance_linux_publicip" { # this is just a name and it could be anything.
#   description = "information regarding linux instance public IP"
#   value       = aws_instance.linux_instance[*].public_ip # Display IP address of the Public instance 

# }
# output "Instance_linux_publicdns" {
#   description = "information regarding linux instance"
#   value       = aws_instance.linux_instance[*].public_dns
# }

# output "Instance_linux_id" {
#   description = "information regarding linux instance id"
#   value       =  aws_instance.linux_instance[*].id
# }
# output "Instance_linux_ami" {
#   description = "information regarding linux instance ami"
#   value       =  aws_instance.linux_instance[*].ami
# }