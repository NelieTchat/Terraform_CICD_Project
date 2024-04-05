# module/vnetworking/variable
variable "aws_region" {
  description = "The region where the VPC will be created."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "aws_availability_zone" {
  description = "Availability zone for the VPC"
  type        = string
}

variable "nat_gateway_subnet_name" {
  type        = string
  description = "Name of the public subnet for the NAT gateway"
}

variable "terra_pub_subnets" {
  type = map(object({
    cidr_block = string
  }))
}

variable "terra_priv_subnets" {
  type = map(object({
    cidr_block = string
  }))
}

