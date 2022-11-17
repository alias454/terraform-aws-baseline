#arn - ARN of the trail.
#home_region - Region in which the trail was created.
#id - Name of the trail.

#output "analyzer_arn" {
#  value       = join(",", aws_accessanalyzer_analyzer.analyzer[*].arn)
#  description = "Analyzer ARN"
#}
#
#output "analyzer_id" {
#  value       = join(",", aws_accessanalyzer_analyzer.analyzer[*].id)
#  description = "Analyzer ID"
#}

#output "config_sns_topic" {
#  description = "The SNS topic that AWS Config delivers notifications to"
#  value       = var.enabled && var.sns_enabled ? join("", aws_sns_topic.config[*].arn) : null
#}