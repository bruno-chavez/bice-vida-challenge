variable "cluster_name" {
  type        = string
  description = "Name for the ECS cluster"
}

variable "enable_container_insight" {
  type        = bool
  description = "Enables container insights, expensive as fuck tho (i think)"
}