#modules/network
resource "aws_vpc" "vpc_cidr" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment_name}VPC"
  }
}

resource "aws_subnet" "public_subnet1_cidr" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = element(data.aws_availability_zones.available.names, 0)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment_name}PublicSubnet1"
  }
}

resource "aws_subnet" "public_subnet2_cidr" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = element(data.aws_availability_zones.available.names, 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment_name}PublicSubnet2"
  }
}

resource "aws_subnet" "private_subnet1_cidr" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = element(data.aws_availability_zones.available.names, 0)

  tags = {
    Name = "${var.environment_name}PrivateSubnet1"
  }
}

resource "aws_subnet" "private_subnet2_cidr" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = element(data.aws_availability_zones.available.names, 1)

  tags = {
    Name = "${var.environment_name}PrivateSubnet2"
  }
}

resource "aws_subnet" "private_subnet3_cidr" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet3_cidr
  availability_zone = element(data.aws_availability_zones.available.names, 2)

  tags = {
    Name = "${var.environment_name}PrivateSubnet3"
  }
}

resource "aws_subnet" "private_subnet4_cidr" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet4_cidr
  availability_zone = element(data.aws_availability_zones.available.names, 3)

  tags = {
    Name = "${var.environment_name}PrivateSubnet4"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "{aws_vpc.vpc.id}"

  tags = {
    Name = "${var.environment_name}InternetGateway"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet1.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment_name}PublicRouteTable"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment_name}PrivateRouteTable"
  }
}
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet3_association" {
  subnet_id      = aws_subnet.private_subnet3.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet4_association" {
  subnet_id      = aws_subnet.private_subnet4.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route" "private_route_to_internet" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}