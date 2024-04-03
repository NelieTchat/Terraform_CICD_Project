# variable "environment_name" {
#   description = "Creating security groups for LoadBalancer and WebServer - EnvironmentName in params is connected to Outputs in udagram/udacityProject VPC"
#   type        = string
#   default     = "Dev"
# }
variable "environment_name" {
  description = "Environment name"
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

# variable "subnet_id" {
#   description = "ID of the public subnet where NAT Gateway will be deployed"
#   type        = string
# }
# Create variables on aws
variable "region" {
  description = "The AWS region where resources will be provisioned"
  type        = string
#   default     = "us-east-1"  # You can specify the default region here
}
# variable "vpc_id" {
#   description = "ID of the VPC"
# }

variable "web_app_security_group_source_cidr" {
  description = "CIDR block for the source of the web application security group"
}

variable "lb_security_group_source_cidr" {
  description = "CIDR block for the source of the load balancer security group"
}

# variable "subnet_id" {
#   description = "ID of the subnet"
# }


# variable "ssh_access_cidr" {
#   type = list(string)
#   default = ["0.0.0.0/0"]  # Replace with your desired CIDR block
# }

# variable "vpc_cidr" {
#   description = "CIDR block for the VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# variable "public_subnet1_cidr" {
#   description = "CIDR block for the first public subnet"
#   type        = string
#   default     = "10.0.0.0/24"
# }

# variable "public_subnet2_cidr" {
#   description = "CIDR block for the second public subnet"
#   type        = string
#   default     = "10.0.1.0/24"
# }

# variable "private_subnet1_cidr" {
#   description = "CIDR block for the first private subnet"
#   type        = string
#   default     = "10.0.2.0/24"
# }

# variable "private_subnet2_cidr" {
#   description = "CIDR block for the second private subnet"
#   type        = string
#   default     = "10.0.3.0/24"
# }

# variable "private_subnet3_cidr" {
#   description = "CIDR block for the third private subnet"
#   type        = string
#   default     = "10.0.4.0/24"
# }

# variable "private_subnet4_cidr" {
#   description = "CIDR block for the fourth private subnet"
#   type        = string
#   default     = "10.0.5.0/24"
# }


# variable "instance_type" {
#   type        = string
#   description = "The type of the instance"
#   default     = "t2.micro"
# }
# variable "instance_key_pair" {
#   type        = string
#   description = "key pair name"
#   default     = "DevOps_key_Pair"
# }

# variable "cidr_block_mypublic_ip" {
#   type        = string
#   description = "my public IP"
#   default     = "xx.xxx.xx.2/32" #cidr_blocks = ["11.xx.xx.xx/32"] #replace it with your ip address
# }

# variable "instance_type_list" {
#   description = "list of possible instance types"
#   type        = list(string) 
#   default     = ["t2.micro", "t2.large", "t2.medium", "t3.nano", "t3.micro", "c5.large"]
# }

# # variable "instance_type_map" {
# #   type        = map(string)
# #   description = "list of possible instance types"
# #   default = {
# #     dev  = "t2.small"
# #     qa   = "t2.micro"
# #     prod = "t2.large"
# #   }
# # }

# variable "my_terra_hello_world" { # using string interpolation to rename the hello world instance
#   description = "Renaming the instance"
#   type        = string
#   default     = "base-instance"
# }
# variable "image_id" {
#   type    = string
#   default = "ami-074cce78125f09d61"
#  }