module "networking" {
  source = "./Modules/networking"

  # Use consistent variable naming (all lowercase with underscores)
  aws_region            = var.aws_region
  vpc_cidr              = var.vpc_cidr
  aws_availability_zone = var.aws_availability_zone # Assuming this is a list of strings

  # Assuming these are not required by the module
  terra_pub_subnets = var.terra_pub_subnets
  terra_priv_subnets = var.terra_priv_subnets

  nat_gateway_subnet_name = var.nat_gateway_subnet_name
}





