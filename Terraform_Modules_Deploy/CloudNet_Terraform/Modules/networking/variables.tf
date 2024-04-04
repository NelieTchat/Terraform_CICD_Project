<<<<<<< HEAD
# module/vnetworking/variable
variable "aws_region" {
  description = "The region where the VPC will be created."
=======
# modules variables
variable "environment_name" {
  description = "The environment name"
>>>>>>> 6fc70ed423ad9265eec9df1092eec5a0f3de8117
  type        = string
}

variable "vpc_cidr" {
<<<<<<< HEAD
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
=======
  description = "CIDR block for the VPC"
  type        = string
}

# variable "availability_zones" {
#   default = data.aws_availability_zones.available.names
# }

variable "terra_pub_sub1" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "terra_pub_sub2" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "terra_priv_sub1" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "terra_priv_sub2" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "terra_priv_sub3" {
  description = "CIDR block for the third private subnet"
  type        = string
}

variable "terra_priv_sub4" {
  description = "CIDR block for the fourth private subnet"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}

# variable "lb_security_group_source_cidr" {
#   description = "CIDR block for allowing inbound traffic to the Load Balancer"
#   type        = string
# }

# variable "web_app_security_group_source_cidr" {
#   description = "CIDR block for allowing inbound traffic to the Web Application"
#   type        = string
# }
variable "ssh_access_cidr" {
  type = list(string)
  default = ["0.0.0.0/0"]  # Replace with your desired CIDR block
>>>>>>> 6fc70ed423ad9265eec9df1092eec5a0f3de8117
}
