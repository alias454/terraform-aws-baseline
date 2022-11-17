# Set up AWS Config recorder to publish results and send notifications if SNS is enabled
resource "aws_sns_topic" "sns_topic" {
  count = var.enabled && var.sns_enabled ? 1 : 0

  name              = var.sns_topic_name
  kms_master_key_id = var.kms_key_id

  tags = merge(
    var.tags,
    {
      Name = var.sns_topic_name
    }
  )
}

# Setup configuration recorder for AWS Config
resource "aws_config_configuration_recorder" "recorder_config" {
  count = var.enabled ? 1 : 0

  name = var.recorder_name

  role_arn = var.iam_role_arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = var.include_global_resource_types
  }
}

# Setup the delivery channel for AWS Config
resource "aws_config_delivery_channel" "recorder_delivery_channel" {
  count = var.enabled ? 1 : 0

  name = var.delivery_channel_name

  s3_bucket_name = var.s3_bucket_name
  s3_key_prefix  = var.s3_key_prefix
  sns_topic_arn  = var.sns_enabled ? join("", aws_sns_topic.sns_topic[*].arn) : null

  snapshot_delivery_properties {
    delivery_frequency = var.delivery_frequency
  }

  depends_on = [
    aws_config_configuration_recorder.recorder_config[0]
  ]
}

# Manages recording status of an AWS Config Configuration Recorder
resource "aws_config_configuration_recorder_status" "recorder_status" {
  count = var.enabled ? 1 : 0

  name = aws_config_configuration_recorder.recorder_config[0].id

  is_enabled = true

  depends_on = [
    aws_config_delivery_channel.recorder_delivery_channel[0]
  ]
}
