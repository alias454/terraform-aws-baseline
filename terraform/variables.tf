# Get access to Account ID, User ID, and ARN from current AWS provider
data "aws_caller_identity" "current" {}

variable "region" {
  description = "Default AWS region where global resources are set up"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Specifies additional default tag keys and values"
  type        = map(string)
  default = {
    "Terraform" = true
  }
}

variable "target_regions" {
  description = "List of enabled AWS regions"
  type        = list(string)
  default = [
    "us-east-1",      # US East (N. Virginia)
    "us-east-2",      # US East (Ohio)
    "us-west-1",      # US West (N. California)
    "us-west-2",      # US West (Oregon)
    "ap-northeast-1", # Asia Pacific (Tokyo)
    "ap-northeast-2", # Asia Pacific (Seoul)
    "ap-northeast-3", # Asia Pacific (Osaka-Local)
    "ap-south-1",     # Asia Pacific (Mumbai)
    "ap-southeast-1", # Asia Pacific (Singapore)
    "ap-southeast-2", # Asia Pacific (Sydney)
    "ca-central-1",   # Canada (Central)
    "eu-central-1",   # EU (Frankfurt)
    "eu-north-1",     # EU (Stockholm)
    "eu-west-1",      # EU (Ireland)
    "eu-west-2",      # EU (London)
    "eu-west-3",      # EU (Paris)
    "sa-east-1"       # South America (Sao Paulo)
  ]
}

variable "config_sns_topic_name" {
  description = "SNS Topic to be used for AWS Config changes if enabled"
  type        = string
  default     = "default-config-topic"
}

variable "cloudwatch_log_group_name" {
  description = "Name of the log group for baseline CloudTrail configuration"
  type        = string
  default     = "default-cloudtrail-log-group"
}

variable "cloudtrail_name" {
  description = "Name of the baseline Cloudtrail trail configuration"
  type        = string
  default     = "default-cloudtrail"
}

variable "cloudtrail_sns_topic_name" {
  description = "SNS Topic to be used for publishing Cloudtrail events if enabled"
  type        = string
  default     = "default-cloudtrail-topic"
}

# https://docs.aws.amazon.com/awscloudtrail/latest/APIReference/API_DataResource.html
# S3 buckets, Lambda functions, or DynamoDB tables specified in the event selectors for a trail to log data events.
# Data events provide information about resource operations performed on or within a resource itself.
# These are also known as data plane operations. Specify up to 250 data resources for a trail.

# Specify ["arn:aws:s3:::"] for all, or [] for none
variable "data_resource_s3_values" {
  description = "List of ARN strings or partial ARN strings to specify as selectors for data resource audit events"
  type        = list(string)
  default = [
    "arn:aws:s3:::"
  ]
}

# Specify ["arn:aws:lambda"] for all, or [] for none
variable "data_resource_lambda_values" {
  description = "List of ARN strings or partial ARN strings to specify as selectors for data resource audit events"
  type        = list(string)
  default = [
    "arn:aws:lambda"
  ]
}

# Specify ["arn:aws:dynamodb"] for all, or [] for none
variable "data_resource_dynamodb_values" {
  description = "List of ARN strings or partial ARN strings to specify as selectors for data resource audit events"
  type        = list(string)
  default = [
    "arn:aws:dynamodb"
  ]
}

# --------------------------------------------------------------------------------------------------
# S3 Bucket Policies
# --------------------------------------------------------------------------------------------------
# Deny access from http but allow https policy
data "aws_iam_policy_document" "config_s3bucket_policy" {
  statement {
    effect = "Deny"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${local.config_s3_bucket_name}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
    principals {
      type = "*"
      identifiers = [
        "*"
      ]
    }
  }
}

# Allow Cloudtrail access and deny access from http but allow https
data "aws_iam_policy_document" "cloudtrail_s3bucket_policy" {
  statement {
    effect = "Deny"
    actions = [
      "s3:*"
    ]
    principals {
      type = "*"
      identifiers = [
        "*"
      ]
    }
    resources = [
      "arn:aws:s3:::${local.cloudtrail_s3_bucket_name}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketAcl"
    ]
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    resources = [
      "arn:aws:s3:::${local.cloudtrail_s3_bucket_name}"
    ]
    condition {
      test     = "StringLike"
      variable = "AWS:SourceArn"
      values = [
        "arn:aws:cloudtrail:${var.region}:${data.aws_caller_identity.current.account_id}:trail/*"
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    resources = [
      "arn:aws:s3:::${local.cloudtrail_s3_bucket_name}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values = [
        "bucket-owner-full-control"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "AWS:SourceArn"
      values = [
        "arn:aws:cloudtrail:${var.region}:${data.aws_caller_identity.current.account_id}:trail/*"
      ]
    }
  }
}

# --------------------------------------------------------------------------------------------------
# AWS Cloudtrail Role Policies
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/send-cloudtrail-events-to-cloudwatch-logs.html
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "cloudtrail_to_cloudwatch_delivery_assume_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "cloudtrail_to_cloudwatch_delivery_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream"
    ]
    resources = [
      "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:${var.cloudwatch_log_group_name}:log-stream:*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:${var.cloudwatch_log_group_name}:log-stream:*"
    ]
  }
}

# --------------------------------------------------------------------------------------------------
# KMS Key to encrypt CloudTrail events Key Policy
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/default-cmk-policy.html
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-permissions-for-sns-notifications.html
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "kms_cloudtrail_key_policy" {
  policy_id = "Key policy created by CloudTrail"

  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "Allow alias creation during setup"
    effect = "Allow"
    actions = [
      "kms:CreateAlias"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values = [
        "ec2.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
  }

  statement {
    sid    = "Allow principals in the account to decrypt log files"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values = [
        "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
      ]
    }
  }

  statement {
    sid    = "Allow Cloudwatch logs"
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    principals {
      type = "Service"
      identifiers = [
        "logs.${var.region}.amazonaws.com"
      ]
    }
    resources = [
      "*"
    ]
    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values = [
        "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:*"
      ]
    }
  }

  statement {
    sid    = "Allow CloudTrail to describe key"
    effect = "Allow"
    actions = [
      "kms:DescribeKey"
    ]
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "Allow CloudTrail to encrypt logs"
    effect = "Allow"
    actions = [
      "kms:GenerateDataKey*"
    ]
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    resources = [
      "*"
    ]
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values = [
        "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
      ]
    }
  }

  statement {
    sid    = "Enable cross account log decryption"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values = [
        "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
      ]
    }
  }

  statement {
    sid    = "Allow CloudTrail to send notifications to the encrypted SNS topic"
    effect = "Allow"
    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    resources = [
      "*"
    ]
  }
}

# --------------------------------------------------------------------------------------------------
# Cloudtrail SNS Topic
# Can be used as subscription target to get feed of audit trail messages
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "cloudtrail_sns_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sns:Publish"
    ]
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    resources = [
      "arn:aws:sns:*:${data.aws_caller_identity.current.account_id}:${var.cloudtrail_sns_topic_name}"
    ]
  }
}

# --------------------------------------------------------------------------------------------------
# AWS Config Recorder Role Policies
# https://docs.aws.amazon.com/config/latest/developerguide/iamrole-permissions.html
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "recorder_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "config.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "recorder_publish_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketAcl",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${local.config_s3_bucket_name}"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectACl"
    ]
    resources = [
      "arn:aws:s3:::${local.config_s3_bucket_name}/*"
    ]
    condition {
      test     = "StringLike"
      variable = "s3:x-amz-acl"
      values = [
        "bucket-owner-full-control"
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "sns:Publish"
    ]
    resources = [
      "arn:aws:sns:*:${data.aws_caller_identity.current.account_id}:${var.config_sns_topic_name}"
    ]
  }
}
