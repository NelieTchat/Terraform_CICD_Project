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
  description = "Private subnets for VPC"
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

#create security groups
resource "aws_security_group" "terra-web-sg1" {
  name        = "terra-web-sg1.id-sg"
  description = "allow web and ssh traffic"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    description = "HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.idr_block_mypublic_ip]
  }
   tags = {
    "Name" = "terra-web-sg"
    }  
    
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #-1 means all protoclole allows to go out
    cidr_blocks = ["0.0.0.0/0"]
  }
}

