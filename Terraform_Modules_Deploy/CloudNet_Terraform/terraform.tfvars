# tfvars
aws_region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
aws_availability_zone = "us-east-1a"

terra_pub_subnets = {
  terra_pub_sub1 = {
    cidr_block = "10.0.0.0/24"
  }
  terra_pub_sub2 = {
    cidr_block = "10.0.1.0/24"
  }
}

terra_priv_subnets = {
  terra_priv_sub1 = {
    cidr_block = "10.0.2.0/24"
  }
  terra_priv_sub2 = {
    cidr_block = "10.0.3.0/24"
  }
  terra_db1_sub = {
    cidr_block = "10.0.4.0/24"
  }
  terra_db2_sub = {
    cidr_block = "10.0.5.0/24"
  }
}

nat_gateway_subnet_name = "terra_pub_sub1"