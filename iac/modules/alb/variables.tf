variable "alb_name" {
  type        = string
  description = "Name for the alb"
}

variable "vpc_id" {
  type        = string
  description = "Id of the vpc where the alb will be placed in"
}
