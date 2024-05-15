module "network" {
  source = "./modules/network"

  aws_region         = var.aws_region
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  subnet_count       = 2
}

module "web_app" {
  source = "./modules/web_app"

  aws_region                = var.aws_region
  availability_zones        = var.availability_zones
  vpc_id                    = module.network.vpc_id
  webapp_sg_id              = module.network.webapp_sg_id
  load_balancer_sg_id       = module.network.load_balancer_sg_id
  webapp_subnet_ids         = module.network.webapp_subnet_ids
  public_subnet_ids         = module.network.public_subnet_ids
  target_group_arn          = var.target_group_arn
  key_name                  = var.key_name
  instance_type             = var.instance_type
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  db_subnet_group_name      = var.db_subnet_group_name
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  webapp_asg_name           = var.webapp_asg_name
  operator_email            = var.operator_email
}

module "database" {
  source = "./modules/database"

  depends_on              = [module.network]
  aws_region              = var.aws_region
  availability_zones      = var.availability_zones
  vpc_id                  = module.network.vpc_id
  db_subnet_ids           = module.network.db_subnet_ids
  db_sg_id                = module.network.db_sg_id
  db_instance_class       = var.db_instance_class
  db_instance_name        = var.db_instance_name
  master_username         = var.master_username
  master_user_password    = var.master_user_password
  db_allocated_storage    = var.db_allocated_storage
  backup_retention_period = var.backup_retention_period
  multi_az                = var.multi_az
  storage_type            = var.storage_type
}



