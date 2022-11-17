# Set default variables for the terraform configuration
variable "enabled" {
  description = "Whether this module is enabled or not"
  type        = bool
  default     = false
}

variable "sns_enabled" {
  description = "Whether to use SNS topics or not. If true, sns_topic_name should be passed in"
  type        = bool
  default     = false
}

variable "sns_topic_name" {
  description = "SNS topic name to be used for notification of log file delivery"
  type        = string
  default     = "cloudtrail-topic"
}

variable "cloudtrail_sns_policy" {
  description = "A valid JSON key policy"
  type        = string
  default     = null
}

variable "cloudtrail_name" {
  description = "The name of the trail"
  type        = string
  default     = "cloudtrail-topic"
}

variable "is_org_trail" {
  description = "Whether the trail is an Organizations trail, which log events for master and all member accounts"
  type        = bool
  default     = false
}

variable "multi_region" {
  description = "Indicates if the trail is created in all regions (true) or is regional (false) defaults to false"
  type        = bool
  default     = true
}

variable "cloudwatch_enabled" {
  description = "Enable delivering the trail to CloudWatch"
  type        = bool
  default     = false
}

variable "cloud_watch_logs_group_arn" {
  description = "Log group ARN that represents a CloudWatch log group to where CloudTrail logs will be delivered"
  type        = string
  default     = null
}

variable "cloud_watch_logs_role_arn" {
  description = "Role ARN for the CloudWatch Logs endpoint to assume to write to a user’s log group"
  type        = string
  default     = null
}

variable "s3_bucket_name" {
  description = "S3 bucket designated to store log files in"
  type        = string
  default     = null
}

variable "s3_key_prefix" {
  description = "The prefix for the specified S3 bucket"
  type        = string
  default     = null
}

variable "enable_log_file_validation" {
  description = "Enable log file integrity validation. Defaults to false"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "Data encryption key (DEK) responsible for encrypting the contents of Amazon SNS messages"
  type        = string
  default     = "alias/aws/sns"
}

variable "include_global_service_events" {
  description = "Whether the trail is publishing events from global services such as IAM to log files. Defaults to true"
  type        = bool
  default     = true
}

# https://docs.aws.amazon.com/awscloudtrail/latest/APIReference/API_DataResource.html
# S3 buckets, Lambda functions, or DynamoDB tables specified in the event selectors for a trail to log data events.
# Data events provide information about resource operations performed on or within a resource itself.
# These are also known as data plane operations. Specify up to 250 data resources for a trail.

# Specify ["arn:aws:s3:::"] for all, or [] for none
variable "data_resource_s3_values" {
  description = "List of ARN strings or partial ARN strings to specify as selectors for data resource audit events"
  type        = list(string)
  default     = []
}

# Specify ["arn:aws:lambda"] for all, or [] for none
variable "data_resource_lambda_values" {
  description = "List of ARN strings or partial ARN strings to specify as selectors for data resource audit events"
  type        = list(string)
  default     = []
}

# Specify ["arn:aws:dynamodb"] for all, or [] for none
variable "data_resource_dynamodb_values" {
  description = "List of ARN strings or partial ARN strings to specify as selectors for data resource audit events"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Specifies additional tag keys and values"
  type        = map(string)
  default = {
    "Terraform" = true
  }
}
