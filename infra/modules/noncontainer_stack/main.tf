resource "aws_elastic_beanstalk_application" "backend" {
  name        = "${var.name_prefix}-backend"
  description = "Python backend application"
}

resource "aws_elastic_beanstalk_environment" "backend" {
  name                = "${var.name_prefix}-backend-env"
  application         = aws_elastic_beanstalk_application.backend.name
  solution_stack_name = var.backend_solution_stack

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.private_app_subnet_ids)
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = var.ecs_tasks_sg_id
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_HOST"
    value     = var.db_endpoint
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PORT"
    value     = tostring(var.db_port)
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_SECRET_ARN"
    value     = var.db_secret_arn
  }

  tags = var.tags
}

resource "aws_amplify_app" "frontend" {
  name       = "${var.name_prefix}-frontend"
  repository = var.amplify_repo_url

  access_token = var.amplify_access_token

  build_spec = <<-EOT
version: 1
frontend:
  phases:
    preBuild:
      commands:
        - npm ci
    build:
      commands:
        - npm run build
  artifacts:
    baseDirectory: .next
    files:
      - '**/*'
  cache:
    paths:
      - node_modules/**/*
EOT

  environment_variables = {
    NEXT_PUBLIC_API_BASE_URL = "/api"
  }

  tags = var.tags
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.frontend.id
  branch_name = "main"
  stage       = "PRODUCTION"
}
