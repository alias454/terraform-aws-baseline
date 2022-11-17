# Set default variables for the terraform module
variable "create" {
  description = "Create IAM role if true"
  type        = bool
  default     = true
}

variable "iam_name" {
  description = "Name of the IAM role to create"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the IAM role"
  type        = string
  default     = null
}

variable "assume_role_policy" {
  description = "JSON data for sts assume role"
  type        = string
  default     = null
}

variable "app_policy_data" {
  description = "AWS IAM policy JSON data"
  type        = string
  default     = null
}

variable "allow_aws_managed" {
  description = "Allow adding a managed policy"
  type        = bool
  default     = false
}

variable "managed_policy_arn" {
  description = "ARN of the managed policy to add"
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
