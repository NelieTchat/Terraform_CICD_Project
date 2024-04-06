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

  # public_subnet_ids       = var.public_subnet_ids
  terra_nat_gateway       = var.terra_nat_gateway  # Make sure this variable exists
}

# module "webapp" {
#   source = "./Modules/webapp"

#   terra_lb                        = var.terra_lb
#   internal_lb                    = var.internal_lb
#   lb_listener_port               = var.lb_listener_port
#   terra_tg                       = var.terra_tg
#   target_group_port              = var.target_group_port
#   health_check_interval          = var.health_check_interval
#   health_check_timeout           = var.health_check_timeout
#   health_check_healthy_threshold = var.health_check_healthy_threshold
#   health_check_unhealthy_threshold = var.health_check_unhealthy_threshold

#   public_subnet_ids       = module.networking.public_subnet_ids  # Use the output from networking module
#   private_subnet_ids      = module.networking.private_subnet_ids
#   public_subnet_cidr_blocks  = module.networking.public_subnet_cidr_blocks
#   private_subnet_cidr_blocks = module.networking.private_subnet_cidr_blocks
#   nat_gateway_eip         = module.networking.nat_gateway_eip
# }

