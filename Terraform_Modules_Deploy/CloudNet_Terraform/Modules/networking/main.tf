# VPC
resource "aws_vpc" "vpc" {
  cidr_block          = var.vpc_cidr
  enable_dns_support  = true
  enable_dns_hostnames = true

  tags = {
    Name = "terra-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "terra_igw"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id     = aws_eip.nat_eip.id
  connectivity_type = "public"
  subnet_id     = aws_subnet.terra-pub-sub[var.nat_gateway_subnet].id

  tags = {
    Name = "terra_nat_gateway"
  }
  depends_on = [aws_internet_gateway.terra_igw]
}
# Update subnet creation resources to use the new names
resource "aws_subnet" "terra-pub-sub" {
  for_each = var.terra_pub_subnets

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = format("public-subnet-%s", each.key)
  }
}

# Public Route Table
resource "aws_route_table" "pub-terra-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra_igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Public Subnet Route Table Association
resource "aws_route_table_association" "pub-terra-rt" {
  for_each = var.terra_pub_subnets

  subnet_id     = aws_subnet.terra-pub-sub[each.key].id
  route_table_id = aws_route_table.pub-terra-rt.id
}


resource "aws_subnet" "terra-priv-sub" {
  for_each = var.terra_priv_subnets

  vpc_id            = aws_vpc.vpc.id
  
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = format("private-subnet-%s", each.key)
  }
}

resource "aws_route_table" "priv-terra-rt" {
  for_each = aws_subnet.terra-priv-sub

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "Private Route Table"
  }
}

# Private Subnet Route Table Association
resource "aws_route_table_association" "priv-terra-rt" {
  for_each = var.terra_priv_subnets

  subnet_id     = aws_subnet.terra-priv-sub[each.key].id
  route_table_id = aws_route_table.priv-terra-rt[each.key].id
}

# Load Balancer Security Group
resource "aws_security_group" "load_balancer_sg" {
  vpc_id = aws_vpc.vpc.id

  // Allow TCP traffic on port 80 from anywhere
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow outbound traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "load-balancer-sg"
  }
}

# Web Application Security Group
resource "aws_security_group" "webapp_sg" {
  vpc_id = aws_vpc.vpc.id

  // Allow TCP traffic on port 80 from the load balancer
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id]  # Updated argument
  }

  // Allow TCP traffic on port 22 (SSH) from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow outbound traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webapp_sg"
  }
}

# # Database Security Group
# resource "aws_security_group" "db_sg" {
#   vpc_id = aws_vpc.vpc.id

#   // Allow TCP traffic on port 3306 from the web application security group
#   ingress {
#     from_port         = 3306
#     to_port           = 3306
#     protocol          = "tcp"
#     security_groups   = [aws_security_group.webapp_sg.id]  # Updated argument
#   }

#   // Allow outbound traffic to anywhere
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "db-sg"
#   }
# }

