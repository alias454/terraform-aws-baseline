# Set default variables for the terraform module
variable "enabled" {
  description = "Create KMS key if true"
  type        = bool
  default     = false
}

variable "description" {
  description = "Description of the key as viewed in AWS console"
  type        = string
  default     = null
}

variable "enable_key_rotation" {
  description = "Enable automatic yearly key rotation for an existing KMS key"
  type        = bool
  default     = true
}

variable "multi_region" {
  description = "Indicates if the KMS key is multi-Region (true) or regional (false) defaults to false"
  type        = bool
  default     = false
}

variable "key_usage" {
  description = "Specifies the intended use of the key. Valid values: ENCRYPT_DECRYPT or SIGN_VERIFY"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "customer_master_key_spec" {
  description = "Specifies whether the key is symmetric or asymmetric and the encryption algorithms it supports"
  type        = string
  default     = "SYMMETRIC_DEFAULT"
}

variable "key_deletion_window_in_days" {
  description = "Waiting period in days when AWS KMS deletes the KMS key"
  type        = number
  default     = 14
}

variable "key_policy" {
  description = "A valid JSON key policy"
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
