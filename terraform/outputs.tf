# Output values
output "account_alias" {
  description = "Value of current account ID"
  value       = local.account_alias[data.aws_caller_identity.current.account_id]
}

output "account_id" {
  description = "Value of current account ID"
  value       = data.aws_caller_identity.current.account_id
}
