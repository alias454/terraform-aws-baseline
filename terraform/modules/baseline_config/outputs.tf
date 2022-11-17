output "configuration_recorder" {
  description = "The configuration recorder"
  value       = var.enabled ? aws_config_configuration_recorder.recorder_config[0] : null
}

output "config_sns_topic_name" {
  description = "SNS topic name that AWS Config delivers notifications to"
  value       = var.enabled && var.sns_enabled ? join("", aws_sns_topic.sns_topic[*].name) : null
}
