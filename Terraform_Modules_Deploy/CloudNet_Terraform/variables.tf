# variables
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

variable "terra_nat_gateway" {
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

# variable "public_subnet_ids" {
#   description = "IDs of the public subnets"
#   type        = list(string)
# }
