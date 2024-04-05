module "networking" {
  source = "./Modules/networking"

  aws_region              = var.aws_region
  vpc_cidr                = var.vpc_cidr
  aws_availability_zone   = var.aws_availability_zone
  nat_gateway_subnet_name = var.nat_gateway_subnet_name

  terra_pub_subnets = var.terra_pub_subnets
  terra_priv_subnets = var.terra_priv_subnets
}
