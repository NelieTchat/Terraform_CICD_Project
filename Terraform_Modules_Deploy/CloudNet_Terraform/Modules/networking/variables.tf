# modules variables
variable "environment_name" {
  description = "The environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "private_subnet1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "private_subnet3_cidr" {
  description = "CIDR block for the third private subnet"
  type        = string
}

variable "private_subnet4_cidr" {
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

variable "lb_security_group_source_cidr" {
  description = "CIDR block for allowing inbound traffic to the Load Balancer"
  type        = string
}

variable "web_app_security_group_source_cidr" {
  description = "CIDR block for allowing inbound traffic to the Web Application"
  type        = string
}
variable "ssh_access_cidr" {
  type = list(string)
  default = ["0.0.0.0/0"]  # Replace with your desired CIDR block
}
