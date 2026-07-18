variable "name_prefix" { type = string }
variable "vpc_id" { type = string }
variable "private_app_subnet_ids" { type = list(string) }
variable "ecs_tasks_sg_id" { type = string }
variable "db_secret_arn" { type = string }
variable "db_endpoint" { type = string }
variable "db_port" { type = number }
variable "amplify_repo_url" {
  type        = string
  description = "GitHub repo URL for Amplify"
}
variable "amplify_access_token" {
  type        = string
  description = "GitHub token for Amplify OAuth"
  sensitive   = true
}
variable "backend_solution_stack" {
  type        = string
  default     = "64bit Amazon Linux 2 v3.7.2 running Python 3.11"
}
variable "tags" {
  type    = map(string)
  default = {}
}
