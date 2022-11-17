locals {

  # Match account alias to use as bucket prefix
  account_alias = {
    111111111111 = "aws-baseline-dev"
  }
  s3_bucket_prefix = local.account_alias[data.aws_caller_identity.current.account_id]

  # S3 bucket to store AWS Config logs
  config_s3_bucket_name = "${local.s3_bucket_prefix}-config-bucket"

  # S3 bucket to store cloudtrail logs
  cloudtrail_s3_bucket_name = "${local.s3_bucket_prefix}-cloudtrail-bucket"

  # Define if AWS organizations are used
  use_org_account = false

  # Publish events to Cloudtrail SNS topics
  enable_cloudtrail_sns = false

  # Publish events to AWS Config SNS topics
  enable_config_sns = false

  # Enable cloudtrail
  enable_cloudtrail = true

  # Enable publishing to cloudwatch
  enable_cloudwatch = true

  # Encrypt cloudtrail
  encrypt_cloudtrail = true

  # Enable access analyzer
  enable_analyzer = true

  # Enable AWS config
  enable_config = true
}
