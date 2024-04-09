#variables
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

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "load_balancer_sg_id" {
  type = string
}

variable "webapp_sg_id" {
  description = "Security group ID for the launch template"
  type        = string
}

variable "lt_image_id" {
  description = "AMI ID for the launch template"
  type        = string
}

variable "lt_instance_type" {
  description = "Instance type for the launch template"
  type        = string
}

variable "lt_iam_instance_profile" {
  description = "IAM instance profile name for the launch template"
  type        = string
}

variable "lt_key_pair" {
  description = "Name of the AWS key pair"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC."
}

variable "lt_min_size" {
  description = "The minimum size of the auto scaling group."
}

variable "lt_max_size" {
  description = "The maximum size of the auto scaling group."
}

variable "lt_desired_capacity" {
  description = "The desired capacity of the auto scaling group."
}

variable "lt_target_group_arn" {
  description = "The ARN of the target group for the load balancer."
}

variable "lt_subnets" {
  description = "The list of subnet IDs for the launch template."
  type        = list(string)
}

variable "lt_health_check_type" {
  description = "The type of health check for the target group."
}

variable "lt_health_check_grace_period" {
  description = "The grace period for the health check."
}
