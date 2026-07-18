resource "random_password" "db" {
  length  = 24
  special = true
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name_prefix}-db-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-db-subnet-group"
  })
}

resource "aws_secretsmanager_secret" "db_credentials" {
  name                    = "${var.name_prefix}/db/credentials"
  kms_key_id              = var.kms_key_arn
  recovery_window_in_days = 7

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-db-credentials"
  })
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db.result
    database = var.db_name
  })
}

resource "aws_db_instance" "this" {
  identifier                   = "${var.name_prefix}-postgres"
  engine                       = "postgres"
  engine_version               = var.engine_version
  instance_class               = var.instance_class
  allocated_storage            = var.allocated_storage
  max_allocated_storage        = var.max_allocated_storage
  db_name                      = var.db_name
  username                     = var.db_username
  password                     = random_password.db.result
  db_subnet_group_name         = aws_db_subnet_group.this.name
  vpc_security_group_ids       = [var.db_sg_id]
  storage_encrypted            = true
  kms_key_id                   = var.kms_key_arn
  backup_retention_period      = var.backup_retention_period
  backup_window                = "02:00-03:00"
  maintenance_window           = "Sun:04:00-Sun:05:00"
  performance_insights_enabled = true
  performance_insights_kms_key_id = var.kms_key_arn
  multi_az                     = var.multi_az
  deletion_protection          = var.deletion_protection
  skip_final_snapshot          = false
  final_snapshot_identifier    = "${var.name_prefix}-final-${formatdate("YYYYMMDDhhmm", timestamp())}"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-postgres"
  })
}
