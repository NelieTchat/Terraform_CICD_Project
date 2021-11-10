# create outputs
output "Instance_linux_publicip" { # this is just a name and it could be anything.
  description = "information regarding linux instance public IP"
  value       = aws_instance.linux_instance.public_ip # Display IP address of the Public instance 

}
output "Instance_linux_publicdns" {
  description = "information regarding linux instance"
  value       = aws_instance.linux_instance.public_dns
}

output "Instance_linux_id" {
  description = "information regarding linux instance id"
  value       =  aws_instance.linux_instance.id
}
output "Instance_linux_ami" {
  description = "information regarding linux instance ami"
  value       =  aws_instance.linux_instance.ami
}
