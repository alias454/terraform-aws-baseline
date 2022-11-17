variable "enabled" {
  description = "Whether this module is enabled or not"
  type        = bool
  default     = false
}

variable "analyzer_name" {
  description = "The name for the IAM Access Analyzer resource to be created"
  type        = string
  default     = "default-analyzer"
}

variable "is_org" {
  description = "Whether this analyzer is configured for an org account or an individual account"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Specifies additional tag keys and values"
  type        = map(string)
  default = {
    "Terraform" = true
  }
}
