# Networking Module Call

module "networking" {
  source = "./modules/networking"

  aws_region            = var.aws_region
  vpc_cidr              = var.vpc_cidr
  aws_availability_zone = var.aws_availability_zone
  terra_pub_subnets     = var.terra_pub_subnets
  terra_priv_subnets    = var.terra_priv_subnets
  webapp_sg             = var.webapp_sg
  load_balancer_sg      = var.load_balancer_sg
  # db_sg                   = var.db_sg
  nat_gateway_subnet      = var.nat_gateway_subnet
  nat_gateway_subnet_cidr = var.nat_gateway_subnet_cidr # Define this variable
  nat_gateway_subnet_az   = var.nat_gateway_subnet_az
}

# Web Application Module Call
module "web_app" {
  source = "./modules/web_app"

  lt_instance_type = var.lt_instance_type
  lt_key_pair      = var.lt_key_pair
  webapp_sg_id     = module.networking.webapp_sg_id
  vpc_id           = var.vpc_id

  lt_min_size                  = var.lt_min_size
  lt_max_size                  = var.lt_max_size
  lt_desired_capacity          = var.lt_desired_capacity
  lt_target_group_arn          = var.lt_target_group_arn
  lt_subnets                   = var.lt_subnets
  lt_health_check_type         = var.lt_health_check_type
  lt_health_check_grace_period = var.lt_health_check_grace_period
  load_balancer_sg_id          = var.load_balancer_sg_id
  public_subnet_ids            = module.networking.public_subnet_ids
  # private_subnet_ids           = module.networking.private_subnet_ids
}
