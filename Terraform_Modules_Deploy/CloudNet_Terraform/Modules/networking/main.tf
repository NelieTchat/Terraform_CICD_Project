# modules/network/main.tf

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment_name}VPC"
  }
}

# Create IGW
resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment_name}InternetGateway"
  }
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.terra_pub_sub1[0].id
}

# Create public and private subnets
resource "aws_subnet" "terra_pub_sub1" {
  count             = length(var.availability_zones)
  vpc_id            = var.vpc_id
  cidr_block        = var.terra_pub_sub1
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment_name}PublicSubnet1"
  }
}

resource "aws_subnet" "terra_pub_sub2" {
  count             = length(var.availability_zones)
  vpc_id            = var.vpc_id
  cidr_block        = var.terra_pub_sub2
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment_name}PublicSubnet2"
  }
}

resource "aws_subnet" "terra_priv_sub1" {
  count             = length(var.availability_zones)
  vpc_id            = var.vpc_id
  cidr_block        = var.terra_priv_sub1
  availability_zone = data.aws_availability_zones.available.names [0]

  tags = {
    Name = "${var.environment_name}PrivateSubnet1"
  }
}

resource "aws_subnet" "terra_priv_sub2" {
  count             = length(var.availability_zones)
  vpc_id            = var.vpc_id
  cidr_block        = var.terra_priv_sub2
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.environment_name}PrivateSubnet2"
  }
}

resource "aws_subnet" "terra_priv_sub3" {
  count             = length(var.availability_zones)
  vpc_id            = var.vpc_id
  cidr_block        = var.terra_priv_sub3
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "${var.environment_name}PrivateSubnet3"
  }
}

resource "aws_subnet" "terra_priv_sub4" {
  count             = length(var.availability_zones)
  vpc_id            = var.vpc_id
  cidr_block        = var.terra_priv_sub4
  availability_zone = data.aws_availability_zones.available.names[3]

  tags = {
    Name = "${var.environment_name}PrivateSubnet4"
  }
}

# Create public route table
resource "aws_route_table" "pub_terra_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra_igw.id
  }

  tags = {
    Name = "${var.environment_name}PublicRouteTable"
  }
}

resource "aws_route_table" "priv_terra_rt" {
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment_name}PrivateRouteTable"
  }
}

resource "aws_route_table_association" "pub1_terra_rt" {
  subnet_id      = aws_subnet.terra_pub_sub1[0].id
  route_table_id = aws_route_table.pub_terra_rt.id
}

resource "aws_route_table_association" "pub2_terra_rt" {
  subnet_id      = aws_subnet.terra_pub_sub2[0].id
  route_table_id = aws_route_table.pub_terra_rt.id
}

resource "aws_route_table_association" "priv1_terra_rt" {
  count = length(aws_subnet.terra_priv_sub1)  // Define count based on the number of subnets

  subnet_id      = aws_subnet.terra_priv_sub1[count.index].id
  route_table_id = aws_route_table.priv_terra_rt.id
}

resource "aws_route_table_association" "priv2_terra_rt" {
  count = length(aws_subnet.terra_priv_sub2)  // Define count based on the number of subnets

  subnet_id      = aws_subnet.terra_priv_sub2[count.index].id
  route_table_id = aws_route_table.priv_terra_rt.id
}

resource "aws_route_table_association" "priv3_terra_rt" {
  count = length(aws_subnet.terra_priv_sub3)  // Define count based on the number of subnets

  subnet_id      = aws_subnet.terra_priv_sub3[count.index].id
  route_table_id = aws_route_table.priv_terra_rt.id
}

resource "aws_route_table_association" "priv4_terra_rt" {
  count = length(aws_subnet.terra_priv_sub4)  // Define count based on the number of subnets

  subnet_id      = aws_subnet.terra_priv_sub4[count.index].id
  route_table_id = aws_route_table.priv_terra_rt.id
}
