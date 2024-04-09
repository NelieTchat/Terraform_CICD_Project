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
  db_sg                 = var.db_sg
  terra_nat_gateway     = var.terra_nat_gateway

  public_subnet_ids  = var.public_subnet_ids
  private_subnet_ids = var.private_subnet_ids

  # Provide the missing arguments
  webapp_sg_id = var.webapp_sg_id
}


# Web Application Module Call
module "web_app" {
  source = "./modules/web_app"

  lt_instance_type        = var.lt_instance_type
  lt_image_id             = var.lt_image_id
  lt_iam_instance_profile = var.lt_iam_instance_profile
  lt_key_pair             = var.lt_key_pair
  webapp_sg_id            = module.networking.webapp_sg_id
  vpc_id                  = var.vpc_id
  
  lt_min_size           = var.lt_min_size
  lt_max_size           = var.lt_max_size
  lt_desired_capacity   = var.lt_desired_capacity
  lt_target_group_arn   = var.lt_target_group_arn
  lt_subnets            = var.lt_subnets
  lt_health_check_type  = var.lt_health_check_type
  lt_health_check_grace_period = var.lt_health_check_grace_period
}
