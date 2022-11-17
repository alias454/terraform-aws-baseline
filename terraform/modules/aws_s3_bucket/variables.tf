# Set default variables for the terraform configuration
variable "bucket_name" {
  description = "Bucket name to be created"
  type        = string
  default     = null
}

variable "bucket_acl" {
  description = "Bucket acl can be private or public"
  type        = string
  default     = "private"
}

variable "enable_bucket_versioning" {
  description = "Enable bucket versioning"
  type        = string
  default     = "Disabled" # "Enabled"
}

variable "enable_lifecycle_rules" {
  description = "Enable bucket lifecycle rules"
  type        = string
  default     = "Enabled"
}

variable "lifecycle_move_to_standard_ia" {
  description = "Days until data migrates to STANDARD_IA storage class"
  type        = number
  default     = 30
}

variable "lifecycle_move_to_glacier" {
  description = "Days until data migrates to GLACIER storage class"
  type        = number
  default     = 90
}

variable "lifecycle_expiration" {
  description = "Days to keep data before purging"
  type        = number
  default     = 365
}

variable "expire_noncurrent_versions_in_days" {
  description = "Expiration in days for non-current file versions"
  type        = number
  default     = 90
}

variable "enable_s3_policy" {
  description = "Attach S3 bucket policy"
  type        = bool
  default     = false
}

variable "s3_bucket_policy" {
  description = "Policy that is attached to an S3 bucket"
  type        = string
  default     = null
}

variable "block_public_acls" {
  description = "Public block acls setting to enable blocking"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Public block policy setting to enable blocking"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public acls setting to enable blocking"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public buckets setting to enable blocking"
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
