variable "name_prefix" { type = string }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "instance_class" { type = string }
variable "allocated_storage" { type = number }
variable "max_allocated_storage" { type = number }
variable "multi_az" { type = bool }
variable "engine_version" { type = string }
variable "private_db_subnet_ids" { type = list(string) }
variable "db_sg_id" { type = string }
variable "kms_key_arn" { type = string }
variable "backup_retention_period" { type = number }
variable "deletion_protection" { type = bool }
variable "tags" {
  type    = map(string)
  default = {}
}
