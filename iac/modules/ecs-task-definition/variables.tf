variable "name" {
  type        = string
  description = "Generic name used to generate resources"
}

variable "execution_role_arn" {
  type        = string
  description = "ARN of the role used by the ecs cluster to execute tasks"
}

# Container variables
variable "ecr_repository_url" {
  type        = string
  description = "URL of the ecr repository where the Docker image is"
}

variable "port" {
  type        = number
  description = "Port to be used by the container"
}

variable "container_memory_units" {
  type        = number
  description = "memory units to be used by the container"
}

variable "container_cpu_units" {
  type        = number
  description = "cpu units to be used by the container"
}


# CloudWatch log group variables
variable "region" {
  type        = string
  description = "region for the cloudwatch log group"
}