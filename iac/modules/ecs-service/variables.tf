variable "name" {
  type        = string
  description = "Generic name of the service"
}

variable "cluster_id" {
  type        = string
  description = "Id of the ecs cluster"
}

variable "port" {
  type        = number
  description = "Port to use by the task"
}

variable "vpc_id" {
  type        = string
  description = "Id of the VPC where the security grgroupiup will be placed in"
}

variable "alb_security_group_id" {
  type        = string
  description = "Security group id of the sg that will redirect traffic to the service"
}

variable "alb_listener_arn" {
  type        = string
  description = "ARN of the alb listener"
}

variable "path_pattern" {
  type        = string
  description = "path to match ecs services"
}

variable "task_definition" {
  type        = string
  description = "task definition for the service"
}