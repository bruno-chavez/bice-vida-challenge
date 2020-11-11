variable "role_name" {
  type        = string
  description = "Name for the role"
}

variable "service_to_assume_role" {
  type        = string
  description = "AWS service that is going to assume the IAM role"
}
