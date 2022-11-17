# --------------------------------------------------------------------------------------------------
# AWS Cloudtrail Baseline
# --------------------------------------------------------------------------------------------------

# Setup required S3 bucket for data storage
module "cloudtrail_s3bucket_module" {
  source = "./modules/aws_s3_bucket"

  providers = {
    aws = aws.us-east-1
  }

  bucket_name = local.cloudtrail_s3_bucket_name

  enable_s3_policy         = true
  enable_bucket_versioning = "Enabled"
  s3_bucket_policy         = data.aws_iam_policy_document.cloudtrail_s3bucket_policy.json

  tags = var.tags
}

# IAM Role to deliver CloudTrail events to CloudWatch logs group
module "iam_cloudtrail_to_cloudwatch_delivery_role_module" {
  source = "./modules/aws_iam_role"

  providers = {
    aws = aws.us-east-1
  }

  iam_name           = "CloudTrailCloudWatchDelivery"
  description        = "Allow delivery of CloudTrail events to CloudWatch logs group"
  assume_role_policy = data.aws_iam_policy_document.cloudtrail_to_cloudwatch_delivery_assume_policy.json
  app_policy_data    = data.aws_iam_policy_document.cloudtrail_to_cloudwatch_delivery_policy.json

  tags = var.tags
}

# Manage KMS key for encrypting CloudTrail events
module "cloudtrail_aws_kms_key_module" {
  source = "./modules/aws_kms_key"

  providers = {
    aws = aws.us-east-1
  }

  enabled     = local.encrypt_cloudtrail
  description = "KMS key to encrypt CloudTrail events"
  key_policy  = data.aws_iam_policy_document.kms_cloudtrail_key_policy.json

  tags = var.tags
}

# Create CloudWatch logs group to accept CloudTrail events
module "cloudwatch_cloudtrail_log_group_module" {
  source = "./modules/aws_cloudwatch_log_group"

  providers = {
    aws = aws.us-east-1
  }

  enabled    = local.enable_cloudwatch
  group_name = var.cloudwatch_log_group_name
  kms_key_id = local.encrypt_cloudtrail ? module.cloudtrail_aws_kms_key_module.kms_key_arn : null

  tags = var.tags
}

# CloudTrail configuration
module "baseline_cloudtrail_module" {
  source = "./modules/baseline_cloudtrail"

  providers = {
    aws = aws.us-east-1
  }

  enabled = local.enable_cloudtrail

  cloudtrail_name = var.cloudtrail_name
  is_org_trail    = local.use_org_account

  cloudwatch_enabled         = local.enable_cloudwatch
  cloud_watch_logs_group_arn = module.cloudwatch_cloudtrail_log_group_module.cloudwatch_log_group_arn
  cloud_watch_logs_role_arn  = module.iam_cloudtrail_to_cloudwatch_delivery_role_module.iam_role_arn

  s3_bucket_name = local.cloudtrail_s3_bucket_name

  kms_key_id = local.encrypt_cloudtrail ? module.cloudtrail_aws_kms_key_module.kms_key_arn : null

  sns_enabled           = local.enable_cloudtrail_sns # defaults to false
  sns_topic_name        = var.cloudtrail_sns_topic_name
  cloudtrail_sns_policy = data.aws_iam_policy_document.cloudtrail_sns_policy.json

  # S3 specify ["arn:aws:s3:::"] for all, or [] for none
  data_resource_s3_values = var.data_resource_s3_values

  # Lambda specify ["arn:aws:lambda"] for all, or [] for none
  data_resource_lambda_values = var.data_resource_lambda_values

  # DynamoDB specify ["arn:aws:dynamodb"] for all, or [] for none
  data_resource_dynamodb_values = var.data_resource_dynamodb_values

  tags = var.tags

  depends_on = [
    module.cloudtrail_s3bucket_module,
    module.iam_cloudtrail_to_cloudwatch_delivery_role_module,
    module.cloudtrail_aws_kms_key_module,
    module.cloudwatch_cloudtrail_log_group_module
  ]
}
