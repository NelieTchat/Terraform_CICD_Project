variable "webapp_sg_id" {
  description = "Security group ID for the launch template"
  type        = string
}
variable "lt_instance_type" {
  description = "Instance type for the launch template"
  type        = string
}

variable "lt_key_pair" {
  description = "Name of the AWS key pair"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC."
}

variable "lt_desired_capacity" {
  description = "The desired capacity of the auto scaling group."
  type        = number
}

variable "lt_target_group_arn" {
  description = "The ARN of the target group for the load balancer."
  type        = string
}

variable "lt_min_size" {
  description = "The minimum size of the auto scaling group."
  type        = number
}

variable "lt_health_check_type" {
  description = "The type of health check for the target group."
  type        = string
}

variable "lt_max_size" {
  description = "The maximum size of the auto scaling group."
  type        = number
}

variable "lt_health_check_grace_period" {
  description = "The grace period for the health check."
  type        = number
}
variable "load_balancer_sg_id" {
  description = "Security group ID for the load balancer"
  type        = string
}

variable "public_subnet_ids" {
  description = "The list of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "The list of subnet IDs for the launch template."
  type        = list(string)
}

variable "operator_email" {
  description = "Email address of the operator for SNS subscription"
  type        = string
}

variable "webapp_asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}
