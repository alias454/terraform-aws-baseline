# Set default variables for the terraform module
variable "enabled" {
  description = "Create Log Group if true"
  type        = bool
  default     = true
}

variable "group_name" {
  description = "Name for the log group. If omitted terraform will assign a unique random name"
  type        = string
  default     = null
}

variable "retention_in_days" {
  description = "Number of days to retain log events for 0 is forever"
  type        = number
  default     = 365
}

variable "kms_key_id" {
  description = "(Optional) ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = null
}

variable "tags" {
  description = "Specifies additional tag keys and values"
  type        = map(string)
  default = {
    "Terraform" = true
  }
}
