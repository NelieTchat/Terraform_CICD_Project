
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




