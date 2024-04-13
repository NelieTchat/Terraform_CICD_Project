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

variable "nat_gateway_subnet" {
  type        = string
  description = "Name of the public subnet for the NAT gateway"
}

variable "nat_gateway_subnet_cidr" {
  type        = string
  description = "CIDR block for the NAT gateway subnet"
}

variable "nat_gateway_subnet_az" {
  type        = string
  description = "Availability zone for the NAT gateway subnet"
}

variable "terra_pub_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string # Add availability zone for each subnet
  }))
}

variable "terra_priv_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string # Add availability zone for each subnet
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
  description = "The list of subnet IDs for the launch template."
  type        = list(string)
}

variable "subnet_db_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "load_balancer_sg_id" {
  description = "Security group ID for the load balancer"
  type        = string
}

variable "webapp_sg_id" {
  description = "Security group ID for the launch template"
  type        = string
}

variable "db_sg_id" {
  description = "Security group ID for the launch template"
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

# Variables
variable "operator_email" {
  description = "Email address of the operator for SNS subscription"
  type        = string
}

variable "webapp_asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "db_instance_class" {
  description = "The type of database instance"
  type        = string
}

variable "multi_az" {
  description = "Create replica in a different Availability zone."
  type        = bool
}

variable "db_allocated_storage" {
  description = "The size of the database (Gb)."
  type        = number
}

variable "storage_type" {
  description = "The type of storage."
  type        = string
}

variable "master_username" {
  description = "ARN of the Secrets Manager secret containing the database username."
  type        = string
}

variable "master_user_password" {
  description = "ARN of the Secrets Manager secret containing the database password."
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version (e.g., 8.0.28 for MySQL)"
  type        = string
}

variable "db_instance_name" {
  description = "Name of the RDS DB instance"
  type        = string
}

variable "backup_retention_period" {
  description = "The number of days to retain automated backups"
  type        = number
}