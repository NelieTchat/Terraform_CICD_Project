# modules variables
variable "environment_name" {
  description = "The environment name"
  type        = string
}

variable "vpc_cidr" {
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
}
