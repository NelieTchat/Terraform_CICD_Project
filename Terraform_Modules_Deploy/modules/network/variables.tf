variable "aws_region" {
  description = "AWS region"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "subnet_count" {
  description = "Number of subnets to create"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}
