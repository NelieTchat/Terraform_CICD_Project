# main.tf

module "networking" {
  source = "./Modules/networking"

  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  environment_name                 = var.environment_name
  vpc_cidr                         = var.vpc_cidr
  terra_pub_sub1                   = var.terra_pub_sub1
  terra_pub_sub2                   = var.terra_pub_sub2
  terra_priv_sub1                  = var.terra_priv_sub1
  terra_priv_sub2                  = var.terra_priv_sub2
  terra_priv_sub3                  = var.terra_priv_sub3
  terra_priv_sub4                  = var.terra_priv_sub4
  availability_zones               = var.availability_zones
  # lb_security_group_source_cidr    = var.lb_security_group_source_cidr
  # web_app_security_group_source_cidr = var.web_app_security_group_source_cidr
  ssh_access_cidr                  = var.ssh_access_cidr
}
