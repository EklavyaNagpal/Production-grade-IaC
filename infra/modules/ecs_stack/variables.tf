variable "name_prefix" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "private_app_subnet_ids" { type = list(string) }
variable "alb_sg_id" { type = string }
variable "ecs_tasks_sg_id" { type = string }
variable "frontend_image" { type = string }
variable "backend_image" { type = string }
variable "frontend_port" { type = number }
variable "backend_port" { type = number }
variable "desired_count" { type = number }
variable "db_secret_arn" { type = string }
variable "db_endpoint" { type = string }
variable "db_port" { type = number }
variable "kms_key_arn" { type = string }
variable "certificate_arn" {
  type        = string
  default     = null
  description = "Optional ACM certificate ARN for HTTPS listener"
}
variable "tags" {
  type    = map(string)
  default = {}
}
