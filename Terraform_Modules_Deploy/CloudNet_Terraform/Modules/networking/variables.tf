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

variable "nat_gateway_subnet" {
  type    = string
}

variable "nat_gateway_subnet_cidr" {
  type = string
  description = "CIDR block for the NAT gateway subnet"
}

variable "nat_gateway_subnet_az" {
  type = string
  description = "Availability zone for the NAT gateway subnet"
}


variable "terra_pub_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string  
  }))
}

variable "terra_priv_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string  
  }))
}

variable "webapp_sg" {
  description = "Name of the security group for the web application"
  type        = string
}

variable "load_balancer_sg" {
  description = "Name of the security group for the load balancer"
  type        = string
}

variable "db_sg" {
  description = "Name of the security group for the database"
  type        = string
}


