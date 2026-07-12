module "networking" {
  source = "./modules/networking"

  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  common_tags          = local.common_tags
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  vpc_id       = module.networking.vpc_id
  common_tags  = local.common_tags
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  project_name       = var.project_name
  log_retention_days = var.log_retention_days
  common_tags        = local.common_tags
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  common_tags  = local.common_tags
}

module "ecs" {

  source = "./modules/ecs"

  project_name = var.project_name
  common_tags  = local.common_tags

  frontend_image = "${module.ecr.frontend_repository_url}:latest"
  backend_image  = "${module.ecr.backend_repository_url}:latest"

  frontend_log_group = module.cloudwatch.frontend_log_group_name
  backend_log_group  = module.cloudwatch.backend_log_group_name

  subnet_ids = module.networking.public_subnet_ids

  frontend_security_group_id = module.security.frontend_security_group_id
  backend_security_group_id  = module.security.backend_security_group_id

  frontend_target_group_arn = module.alb.frontend_target_group_arn
  backend_target_group_arn  = module.alb.backend_target_group_arn

  depends_on = [
    module.alb
  ]
}

module "alb" {
  source = "./modules/alb"

  project_name = var.project_name

  vpc_id = module.networking.vpc_id

  subnet_ids = module.networking.public_subnet_ids

  alb_security_group_id = module.security.alb_security_group_id

  common_tags = local.common_tags
}