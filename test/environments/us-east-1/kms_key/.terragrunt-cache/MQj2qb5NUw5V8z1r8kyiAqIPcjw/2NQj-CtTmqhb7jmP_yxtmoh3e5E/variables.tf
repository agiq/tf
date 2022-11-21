variable "alias" {
  description = "Alias name to KMS key"
  type = string
}

variable "description" {
  description = "Description record to KMS key"
  type = string
  default = "Default descriptoin to KMS key"
}

variable "deletion_window_in_days" {
  description = "Deletion persion of key in days"
  type = number
  default = 15
}