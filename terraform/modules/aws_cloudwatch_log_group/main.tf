# Create CloudWatch Log group
resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  count = var.enabled ? 1 : 0

  name              = var.group_name
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id

  tags = merge(
    var.tags,
    {
      Name = var.group_name
    }
  )
}
