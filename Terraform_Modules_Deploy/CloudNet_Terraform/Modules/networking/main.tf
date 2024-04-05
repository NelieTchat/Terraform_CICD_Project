
# VPC
resource "aws_vpc" "terra-vpc" {
  cidr_block          = var.vpc_cidr
  enable_dns_support  = true
  enable_dns_hostnames = true

  tags = {
    Name = "terra-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "terra-igw" {
  vpc_id = aws_vpc.terra-vpc.id

  tags = {
    Name = "terra-igw"
  }
}

# Public Subnets
resource "aws_subnet" "terra-pub-sub" {
  for_each = var.terra_pub_subnets

  vpc_id            = aws_vpc.terra-vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = var.aws_availability_zone

  tags = {
    Name = format("terra-pub-sub-%s", each.key)
  }
}

# Public Route Table
resource "aws_route_table" "pub-terra-rt" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-igw.id
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

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.terra-pub-sub[var.nat_gateway_subnet_name].id
}

# Private Subnets
resource "aws_subnet" "terra-priv-sub" {
  for_each = var.terra_priv_subnets

  vpc_id            = aws_vpc.terra-vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = var.aws_availability_zone

  tags = {
    Name = format("terra-priv-sub-%s", each.key)
  }
}

# Private Route Table
resource "aws_route_table" "priv-terra-rt" {
  vpc_id = aws_vpc.terra-vpc.id

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
  route_table_id = aws_route_table.priv-terra-rt.id
}
