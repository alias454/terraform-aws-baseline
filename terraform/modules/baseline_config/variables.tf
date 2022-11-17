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
  description = "The name of the SNS Topic to be used to notify configuration changes"
  type        = string
  default     = "config-topic"
}

variable "kms_key_id" {
  description = "Data encryption key (DEK) responsible for encrypting the contents of Amazon SNS messages"
  type        = string
  default     = "alias/aws/sns"
}

variable "iam_role_arn" {
  description = "The ARN of the IAM Role which AWS Config will use"
  type        = string
  default     = null
}

variable "s3_bucket_name" {
  description = "S3 bucket to store configuration snapshots in"
  type        = string
  default     = null
}

variable "s3_key_prefix" {
  description = "The prefix for the specified S3 bucket"
  type        = string
  default     = ""
}

variable "delivery_frequency" {
  description = "Frequency which AWS Config sends a snapshot into the S3 bucket"
  type        = string
  default     = "One_Hour"
}

variable "recorder_name" {
  description = "Name of the configuration recorder"
  type        = string
  default     = "default"
}

variable "delivery_channel_name" {
  description = "Name of the delivery channel"
  type        = string
  default     = "default"
}

variable "include_global_resource_types" {
  description = "Specifies whether AWS Config includes all supported global resource types that it records"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Specifies additional tag keys and values"
  type        = map(string)
  default = {
    "Terraform" = true
  }
}
