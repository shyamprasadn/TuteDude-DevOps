output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "alb_security_group_id" {
  value = module.security.alb_security_group_id
}

output "frontend_security_group_id" {
  value = module.security.frontend_security_group_id
}

output "backend_security_group_id" {
  value = module.security.backend_security_group_id
}

output "frontend_log_group" {
  value = module.cloudwatch.frontend_log_group_name
}

output "backend_log_group" {
  value = module.cloudwatch.backend_log_group_name
}

output "backend_ecr_url" {
  value = module.ecr.backend_repository_url
}


output "frontend_ecr_url" {
  value = module.ecr.frontend_repository_url
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}