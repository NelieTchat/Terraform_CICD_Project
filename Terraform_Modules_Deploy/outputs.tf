output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "webapp_subnet_ids" {
  value = module.network.webapp_subnet_ids
}

output "db_subnet_ids" {
  value = module.network.db_subnet_ids
}

output "public_route_table_id" {
  value = module.network.public_route_table_id
}

output "public_subnet_association_ids" {
  value = module.network.public_subnet_association_ids
}

output "load_balancer_sg_id" {
  value = module.network.load_balancer_sg_id
}

output "webapp_sg_id" {
  value = module.network.webapp_sg_id
}

output "db_sg_id" {
  value = module.network.db_sg_id
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = module.web_app.target_group_arn
}
