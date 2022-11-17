# Setup Cloudtrail to publish notifications to SNS if SNS enabled
resource "aws_sns_topic" "cloudtrail_sns_topic" {
  count = var.enabled && var.sns_enabled ? 1 : 0

  name = var.sns_topic_name

  kms_master_key_id = var.kms_key_id

  tags = merge(
    var.tags,
    {
      Name = var.sns_topic_name
    }
  )
}

# Attach SNS policy to topic
resource "aws_sns_topic_policy" "local_account_cloudtrail" {
  count = var.enabled && var.sns_enabled ? 1 : 0

  arn    = aws_sns_topic.cloudtrail_sns_topic[0].arn
  policy = var.cloudtrail_sns_policy
}

# CloudTrail configuration
resource "aws_cloudtrail" "cloudtrail_trail" {
  count = var.enabled ? 1 : 0

  name = var.cloudtrail_name

  is_organization_trail = var.is_org_trail
  is_multi_region_trail = var.multi_region

  cloud_watch_logs_group_arn = var.cloudwatch_enabled ? "${var.cloud_watch_logs_group_arn}:*" : null
  cloud_watch_logs_role_arn  = var.cloudwatch_enabled ? var.cloud_watch_logs_role_arn : null

  s3_bucket_name             = var.s3_bucket_name
  s3_key_prefix              = var.s3_key_prefix
  enable_log_file_validation = var.enable_log_file_validation

  kms_key_id = var.kms_key_id

  sns_topic_name = var.sns_enabled ? var.sns_topic_name : null

  include_global_service_events = var.include_global_service_events

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    # Need a list to work with for_each, but don't actually want to for_each
    dynamic "data_resource" {
      for_each = length(var.data_resource_s3_values) > 0 ? [true] : []
      content {
        type   = "AWS::S3::Object"
        values = var.data_resource_s3_values
      }
    }

    dynamic "data_resource" {
      for_each = length(var.data_resource_lambda_values) > 0 ? [true] : []
      content {
        type   = "AWS::Lambda::Function"
        values = var.data_resource_lambda_values
      }
    }

    dynamic "data_resource" {
      for_each = length(var.data_resource_dynamodb_values) > 0 ? [true] : []
      content {
        type   = "AWS::DynamoDB::Table"
        values = var.data_resource_dynamodb_values
      }
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.cloudtrail_name
    }
  )
}
