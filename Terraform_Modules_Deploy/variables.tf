// Network variables
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
}

variable "availability_zones" {
  description = "List of availability zones to distribute subnets"
  type        = list(string)
}

// Web_app variables
variable "instance_type" {
  description = "Instance type for the web application instances"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of the RDS DB subnet group"
  type        = string
}

variable "load_balancer_sg_id" {
  description = "Security group ID for the load balancer"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the instances"
  type        = string
}

variable "public_subnet_ids" {
  description = "ID of the subnet where the instances will be launched"
  type        = list(string)
}

variable "webapp_subnet_ids" {
  description = "List of subnet IDs for the web application instances"
  type        = list(string)
}

variable "db_subnet_ids" {
  description = "ID of the subnets where the RDS instances will be launched"
  type        = list(string)
}

variable "db_sg_id" {
  description = "ID of the security group for the RDS instances"
  type        = string
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

variable "ami_name" {
  description = "Name of the AMI to use for the instances"
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

// Databse variables
variable "db_instance_name" {
  description = "Name of the database"
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

variable "backup_retention_period" {
  description = "The number of days to retain automated backups"
  type        = number
}

variable "engine_version" {
  description = "The database engine version."
  type        = string
}
variable "db_instance_type" {
  description = "The type of database instance"
  type        = string
}

variable "read_replica_name" {
  description = "Name of the read replica"
  type        = string
}

variable "read_replica_az" {
  description = "Availability Zone for the read replica"
  type        = string
  default     = "us-east-1c" // specify the az where the db subnet is created
}

