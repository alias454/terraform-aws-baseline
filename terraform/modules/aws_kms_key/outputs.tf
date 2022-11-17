output "kms_key_arn" {
  value       = join(",", aws_kms_key.kms_key[*].arn)
  description = "KMS key ARN"
}

output "kms_key_id" {
  value       = join(",", aws_kms_key.kms_key[*].key_id)
  description = "KMS key ID"
}
