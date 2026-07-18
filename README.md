# AWS Production Deployment Blueprint: Next.js + Python + PostgreSQL

This repository contains a production-grade reference implementation for deploying:

- Next.js frontend
- Python backend
- PostgreSQL database

It includes both deployment patterns:

- Containerized: Amazon ECS Fargate
- Non-containerized: AWS Amplify (frontend) + Elastic Beanstalk (backend)

Core capabilities:

- Terraform-based Infrastructure as Code with reusable modules
- Environment segregation for dev, staging, and prod
- Separate CI/CD workflows for infrastructure and applications
- Secure secret handling via AWS Secrets Manager + IAM least privilege
- Monitoring and alerting with CloudWatch

Detailed implementation guidance is in [docs/Architecture-and-Deployment-Guide.md](docs/Architecture-and-Deployment-Guide.md).
