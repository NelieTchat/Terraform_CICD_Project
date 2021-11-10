# Create variables
variable "aws_region" {
  description = "creating a variable to hold the region name value"
  type        = string
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "terra_pub_sub1" {
  description = "Public subnets for VPC"
  type        = string
  default     = "10.0.0.0/24"
}
variable "aws_availability_zone" {
  description = "Availability zones for VPC"
  type        = string
  default     = "us-east-2a"
}

variable "terra_priv_sub1" {
  description = "Public subnets for VPC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  type        = string
  description = "The type of the instance"
  default     = "t2.micro"
}
variable "instance_key_pair" {
  type        = string
  description = "key pair name"
  default     = "awesome-key"
}

variable "cidr_block_mypublic_ip" {
  type        = string
  description = "my public IP"
  default     = "xxx.xxx.xx.x/32" #cidr_blocks = ["11.xx.xx.xx/32"] #replace it with your ip address
}

variable "instance_type_list" {
  description = "list of possible instance types"
  type        = list(string) #creating a list of string
  default     = ["t2.micro", "t2.large", "t2.medium", "t3.nano", "t3.micro", "c5.large"]
}

variable "instance_type_map" {
  type        = map(string)
  description = "list of possible instance types"
  default = {
    dev  = "t2.small"
    qa   = "t2.micro"
    prod = "t2.large"
  }
}

variable "my_terra_hello_world" { # using string interpolation to rename the hello world instance
  description = "Renaming the instance"
  type        = string
  default     = "base-instance"
}
