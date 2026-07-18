output "db_endpoint" {
  value = module.database.db_endpoint
}

output "db_secret_arn" {
  value = module.database.db_secret_arn
}

output "container_alb_dns" {
  value = var.deployment_mode == "containerized" ? module.ecs_stack[0].alb_dns_name : null
}

output "amplify_domain" {
  value = var.deployment_mode == "non_containerized" ? module.noncontainer_stack[0].amplify_default_domain : null
}

output "beanstalk_env_name" {
  value = var.deployment_mode == "non_containerized" ? module.noncontainer_stack[0].beanstalk_env_name : null
}
