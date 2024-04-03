# main.tf

module "networking" {
  source  = "./Modules/networking" 
  environment_name         = var.environment_name
  vpc_cidr                 = var.vpc_cidr
  public_subnet1_cidr      = var.public_subnet1_cidr
  public_subnet2_cidr      = var.public_subnet2_cidr
  private_subnet1_cidr     = var.private_subnet1_cidr
  private_subnet2_cidr     = var.private_subnet2_cidr
  private_subnet3_cidr     = var.private_subnet3_cidr
  private_subnet4_cidr     = var.private_subnet4_cidr
  availability_zones     = data.aws_availability_zones.available.names
}



 