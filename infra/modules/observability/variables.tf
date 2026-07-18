variable "name_prefix" { type = string }
variable "alarm_topic_arn" {
  type    = string
  default = null
}
variable "db_instance_identifier" { type = string }
variable "ecs_cluster_name" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
