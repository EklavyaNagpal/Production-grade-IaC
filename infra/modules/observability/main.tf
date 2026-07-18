resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  alarm_name          = "${var.name_prefix}-rds-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "RDS CPU above threshold"

  dimensions = {
    DBInstanceIdentifier = var.db_instance_identifier
  }

  alarm_actions = var.alarm_topic_arn == null ? [] : [var.alarm_topic_arn]
  ok_actions    = var.alarm_topic_arn == null ? [] : [var.alarm_topic_arn]

  tags = var.tags
}
