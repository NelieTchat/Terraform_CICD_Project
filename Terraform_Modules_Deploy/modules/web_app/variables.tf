variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type = string
}

variable "availability_zones" {
  description = "List of availability zones to distribute subnets"
  type        = list(string)
}

variable "image_id" {
    description = "The AMI ID to use for the web application instances"
    type = string
}

variable "instance_type" {
  description = "Instance type for the web application instances"
  type = string
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type = number
}

variable "webapp_subnet_ids"{
  description = "List of web application subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC"
  type = string
}

variable "db_subnet_group_name" {
  description = "Name of the RDS DB subnet group"
  type = string
}

variable "load_balancer_sg_id" {
  description = "Security group ID for the load balancer"
  type = string
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the instances"
  type = string
}

variable "webapp_sg_id" {
  description = "ID of the security group for the web application instances"
  type        = string
}

variable "health_check_type" {
  description = "Type of health check to perform"
  type        = string
}

variable "health_check_grace_period" {
  description = "Number of seconds to wait before checking health"
  type        = number
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
}

variable "webapp_asg_name" {
  description = "Name of the Auto Scaling Group for the web application"
  type        = string
}

variable "operator_email" {
  description = "Email address of the operator"
  type        = string
}