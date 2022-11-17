output "cloudwatch_log_group_arn" {
  value       = join(",", aws_cloudwatch_log_group.cloudwatch_log_group[*].arn)
  description = "CloudWatch Log Group ARN"
}

output "cloudwatch_log_group_name" {
  value       = join(",", aws_cloudwatch_log_group.cloudwatch_log_group[*].name)
  description = "CloudWatch Log Group Name"
}
