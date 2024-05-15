# VPC and Internet Gateway
resource "aws_vpc" "MyVpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "MainVPC"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "MyIgw" {
  vpc_id = aws_vpc.MyVpc.id

  tags = {
    Name = "MainIGW"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "public-eips" {
  domain = "vpc"
}

# Create the NAT gateway in the first public subnet
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.public-eips.id
  subnet_id     = aws_subnet.public-subnets[0].id
  connectivity_type = "public"

  tags = {
    Name = "NATGateway"
  }

  # Only create one NAT gateway
  depends_on = [aws_internet_gateway.MyIgw]
}

# Get the list of available availability zones in the current region
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "region-name"
    values = [var.aws_region]
  }
}

# Create the public subnets
resource "aws_subnet" "public-subnets" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.MyVpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index % 2] # Use the first two availability zones
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet-${count.index +1}"
  }

  # Associate each public subnet with the internet gateway
  depends_on = [aws_internet_gateway.MyIgw]
}

# Web App Subnets
resource "aws_subnet" "webapp-subnets" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.MyVpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + var.subnet_count + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index % 2] # Use the same availability zones as the public subnets
  map_public_ip_on_launch = true

  tags = {
    Name = "WebAppSubnet-${count.index +1}"
  }
}

# Database Subnets
resource "aws_subnet" "db-subnets" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.MyVpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + var.subnet_count + 4)
  availability_zone = data.aws_availability_zones.available.names[(count.index + 2) % 3] # Use the third availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "DBSubnet-${count.index +1}"
  }
}

# Public Route Table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.MyVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyIgw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public-subnet-association" {
  count          = var.subnet_count
  subnet_id     = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.public-route-table.id
}

# Private Route Table for Web Subnets
resource "aws_route_table" "webapp-private-route-table" {
  vpc_id = aws_vpc.MyVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "WebPrivateRouteTable"
  }
}

# Private Route Table for Database Subnets
resource "aws_route_table" "db-private-route-table" {
  vpc_id = aws_vpc.MyVpc.id
  tags = {
    Name = "DBPrivateRouteTable"
  }
}

# Associate Web Subnets with Web Private Route Table
resource "aws_route_table_association" "webapp-subnet-association" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.webapp-subnets[count.index].id
  route_table_id = aws_route_table.webapp-private-route-table.id
}

# Associate Database Subnets with DB Private Route Table
resource "aws_route_table_association" "db-subnet-association" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.db-subnets[count.index].id
  route_table_id = aws_route_table.db-private-route-table.id
}

# Load Balancer Security Group
resource "aws_security_group" "load_balancer_sg" {
  vpc_id = aws_vpc.MyVpc.id

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
  vpc_id = aws_vpc.MyVpc.id

  // Allow TCP traffic on port 80 from the load balancer
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }

  // Allow TCP traffic on port 22 from anywhere
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

# Database Security Group
resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.MyVpc.id

  // Allow TCP traffic on port 3306 from the web application security group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webapp_sg.id]
  }

  // Allow outbound traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}