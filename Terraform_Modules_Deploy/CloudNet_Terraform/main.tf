module "networking" {
  source = "./Modules/networking"

  aws_region              = var.aws_region
  vpc_cidr                = var.vpc_cidr
  aws_availability_zone   = var.aws_availability_zone

  terra_pub_subnets       = var.terra_pub_subnets
  terra_priv_subnets      = var.terra_priv_subnets

  webapp_sg               = var.webapp_sg
  load_balancer_sg        = var.load_balancer_sg
  db_sg                   = var.db_sg

  terra_nat_gateway       = var.terra_nat_gateway 
}


module "webapp" {
  source = "./webapp"

  # instance_type            = var.instance_type
  
  vpc_id                   = var.vpc_id
  webapp_security_group_id = var.webapp_security_group_id
  # ami_id                   = var.ami_id
  # instance_profile_arn     = var.instance_profile_arn
}