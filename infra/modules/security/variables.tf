variable "name_prefix" { type = string }
variable "vpc_id" { type = string }
variable "app_port" { type = number }
variable "frontend_port" { type = number }
variable "db_port" { type = number }
variable "tags" {
  type    = map(string)
  default = {}
}
