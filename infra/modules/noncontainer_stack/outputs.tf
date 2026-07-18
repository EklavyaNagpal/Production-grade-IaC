output "beanstalk_env_name" {
  value = aws_elastic_beanstalk_environment.backend.name
}

output "amplify_default_domain" {
  value = aws_amplify_app.frontend.default_domain
}
