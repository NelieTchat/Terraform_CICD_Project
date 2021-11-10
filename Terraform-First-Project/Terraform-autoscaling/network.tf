
data "aws_ami" "Linux_ami" {
  most_recent = true
  filter { #filter is a dictionary. The filter will go in AWS and fetch the latest ami. AWs 
    name   = "name"
    values = ["amzn2-ami-hvm-*1-x86_64-gp2"]
  }
  owners = ["amazon"]
}

# create custom vpc
resource "aws_vpc" "terra-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "terra-vpc"
  }
}

# create IGW
resource "aws_internet_gateway" "terra-igw" {
  vpc_id = aws_vpc.terra-vpc.id
  tags = {
    Name = "terra-igw"
  }
}

# create public and private subnets
resource "aws_subnet" "terra-pub-sub1" {
  vpc_id            = aws_vpc.terra-vpc.id
  cidr_block        = var.terra_pub_sub1
  availability_zone = var.aws_availability_zone

  tags = {
    Name = "terra-pub-sub1"
  }
}

resource "aws_subnet" "terra-priv-sub1" {
  vpc_id            = aws_vpc.terra-vpc.id
  cidr_block        = var.terra_priv_sub1
  availability_zone = var.aws_availability_zone

  tags = {
    Name = "terra-priv-sub1"
  }
}

# create public route table
resource "aws_route_table" "pub-terra-rt" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-igw.id
  }

  tags = {
    Name = "Public Route Table."
  }
}

resource "aws_route_table_association" "pub-terra-rt" {
  subnet_id      = aws_subnet.terra-pub-sub1.id
  route_table_id = aws_route_table.pub-terra-rt.id
}

# create private route table
resource "aws_route_table" "priv-terra-rt" {
  vpc_id = aws_vpc.terra-vpc.id
}

# create launch configuration
resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc"
  image_id      = data.aws_ami.Linux_ami.id
  instance_type = var.instance_type_map["prod"]
  user_data     = file("install_apache.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "terra-as" {
  name                 = "terraform-asg"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 2
  max_size             = 3
  availability_zones   = [var.aws_availability_zone]

  lifecycle {
    create_before_destroy = true
  }
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
    cidr_blocks = [var.cidr_block_mypublic_ip]
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

#outputs
output "Instance_linux_publicip" { # this is just a name and it could be anything.
  description = "information regarding linux instance public IP"
  value       = aws_instance.linux_instance[*].public_ip # Display IP address of the Public instance 

}
output "Instance_linux_publicdns" {
  description = "information regarding linux instance"
  value       = aws_instance.linux_instance[*].public_dns
}

output "Instance_linux_id" {
  description = "information regarding linux instance id"
  value       =  aws_instance.linux_instance[*].id
}
output "Instance_linux_ami" {
  description = "information regarding linux instance ami"
  value       =  aws_instance.linux_instance[*].ami
}