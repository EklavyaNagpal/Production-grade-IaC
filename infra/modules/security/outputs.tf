output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "ecs_tasks_sg_id" {
  value = aws_security_group.ecs_tasks.id
}

output "db_sg_id" {
  value = aws_security_group.db.id
}

output "kms_key_arn" {
  value = aws_kms_key.app.arn
}
