# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region

}

data "aws_ami" "Linux_ami" {
  most_recent = true
  filter { #filter is a dictionary. The filter will go in AWS and fetch the latest ami. AWs 
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
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

# create public subnet
resource "aws_subnet" "terra-pub-sub1" {
  vpc_id            = aws_vpc.terra-vpc.id
  cidr_block        = var.terra_pub_sub1
  availability_zone = var.aws_availability_zone

  tags = {
    Name = "terra-pub-sub1"
  }
}
# create private subnet
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #-1 means all protoclole allows to go out
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    "Name" = "terra-web-sg"
  }
}

# create public ec2
resource "aws_instance" "linux_instance" {
  ami = data.aws_ami.Linux_ami.id
  #instance_type              = var.instance_type # since we want it dynamic,
  #instance_type              = var.instance_type_list[4]
  instance_type               = var.instance_type_map["prod"]
  key_name                    = var.instance_key_pair
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.terra-pub-sub1.id
  vpc_security_group_ids      = [aws_security_group.terra-web-sg1.id]
  count                       = 3
  tags = {
    Name = "tf-pub-ec2-${var.my_terra_hello_world}-${count.index}" #string interpolation

  }
}
# create private ec2
resource "aws_instance" "linux_instance1" {
  ami = data.aws_ami.Linux_ami.id
  #instance_type         = var.instance_type_list[4]
  instance_type          = var.instance_type_map["prod"]
  key_name               = var.instance_key_pair
  subnet_id              = aws_subnet.terra-pub-sub1.id
  vpc_security_group_ids = [aws_security_group.terra-web-sg1.id]

  tags = {
    Name = "tf-pub-ec2-${var.my_terra_hello_world}"
  }
}


