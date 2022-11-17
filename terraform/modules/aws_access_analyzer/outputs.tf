output "analyzer_arn" {
  value       = join(",", aws_accessanalyzer_analyzer.analyzer[*].arn)
  description = "Analyzer ARN"
}

output "analyzer_id" {
  value       = join(",", aws_accessanalyzer_analyzer.analyzer[*].id)
  description = "Analyzer ID"
}