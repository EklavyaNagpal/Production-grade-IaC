terraform {
  backend "s3" {}
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
  common_tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "terraform"
    Project     = "cd-assessment"
  })
}

module "network" {
  source = "../../modules/network"

  name_prefix              = var.name_prefix
  vpc_cidr                 = var.vpc_cidr
  azs                      = local.azs
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
  single_nat_gateway       = false
  tags                     = local.common_tags
}

module "security" {
  source = "../../modules/security"

  name_prefix   = var.name_prefix
  vpc_id        = module.network.vpc_id
  app_port      = 8000
  frontend_port = 3000
  db_port       = 5432
  tags          = local.common_tags
}

module "database" {
  source = "../../modules/database"

  name_prefix              = var.name_prefix
  db_name                  = var.db_name
  db_username              = var.db_username
  instance_class           = var.db_instance_class
  allocated_storage        = var.db_allocated_storage
  max_allocated_storage    = var.db_max_allocated_storage
  multi_az                 = true
  engine_version           = var.db_engine_version
  private_db_subnet_ids    = module.network.private_db_subnet_ids
  db_sg_id                 = module.security.db_sg_id
  kms_key_arn              = module.security.kms_key_arn
  backup_retention_period  = 35
  deletion_protection      = true
  tags                     = local.common_tags
}

module "ecs_stack" {
  count  = var.deployment_mode == "containerized" ? 1 : 0
  source = "../../modules/ecs_stack"

  name_prefix             = var.name_prefix
  vpc_id                  = module.network.vpc_id
  public_subnet_ids       = module.network.public_subnet_ids
  private_app_subnet_ids  = module.network.private_app_subnet_ids
  alb_sg_id               = module.security.alb_sg_id
  ecs_tasks_sg_id         = module.security.ecs_tasks_sg_id
  frontend_image          = var.frontend_image
  backend_image           = var.backend_image
  frontend_port           = 3000
  backend_port            = 8000
  desired_count           = 3
  db_secret_arn           = module.database.db_secret_arn
  db_endpoint             = module.database.db_endpoint
  db_port                 = module.database.db_port
  kms_key_arn             = module.security.kms_key_arn
  tags                    = local.common_tags
}

module "noncontainer_stack" {
  count  = var.deployment_mode == "non_containerized" ? 1 : 0
  source = "../../modules/noncontainer_stack"

  name_prefix            = var.name_prefix
  vpc_id                 = module.network.vpc_id
  private_app_subnet_ids = module.network.private_app_subnet_ids
  ecs_tasks_sg_id        = module.security.ecs_tasks_sg_id
  db_secret_arn          = module.database.db_secret_arn
  db_endpoint            = module.database.db_endpoint
  db_port                = module.database.db_port
  amplify_repo_url       = var.amplify_repo_url
  amplify_access_token   = var.amplify_access_token
  tags                   = local.common_tags
}

module "observability" {
  source = "../../modules/observability"

  name_prefix            = var.name_prefix
  db_instance_identifier = "${var.name_prefix}-postgres"
  tags                   = local.common_tags
}
