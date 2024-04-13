variable "db_instance_name" {
  description = "Name of the database"
  type = string
}

variable "subnet_db_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "db_instance_class" {
  description = "The type of database instance"
  type = string
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
  description = "The database engine version."
  type        = string
  default     = "8.0.28"
}

variable "db_sg_id" {
  description = "Security group ID for the launch template"
  type        = string
}
variable "backup_retention_period" {
  description = "The number of days to retain automated backups"
  type        = number
}