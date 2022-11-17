# Create KMS key
resource "aws_kms_key" "kms_key" {
  count = var.enabled ? 1 : 0

  description = var.description

  key_usage                = var.key_usage
  multi_region             = var.multi_region
  customer_master_key_spec = var.customer_master_key_spec

  enable_key_rotation     = var.enable_key_rotation
  deletion_window_in_days = var.key_deletion_window_in_days

  policy = var.key_policy

  tags = var.tags
}
