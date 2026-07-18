variable "aws_region" { type = string }
variable "environment" { type = string }
variable "name_prefix" { type = string }
variable "deployment_mode" {
  type = string
  validation {
    condition     = contains(["containerized", "non_containerized"], var.deployment_mode)
    error_message = "deployment_mode must be containerized or non_containerized"
  }
}
variable "vpc_cidr" { type = string }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_app_subnet_cidrs" { type = list(string) }
variable "private_db_subnet_cidrs" { type = list(string) }
variable "frontend_image" { type = string }
variable "backend_image" { type = string }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_instance_class" { type = string }
variable "db_allocated_storage" { type = number }
variable "db_max_allocated_storage" { type = number }
variable "db_engine_version" { type = string }
variable "amplify_repo_url" { type = string }
variable "amplify_access_token" {
  type      = string
  sensitive = true
}
variable "tags" {
  type    = map(string)
  default = {}
}
