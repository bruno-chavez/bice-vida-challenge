variable "subnets" {
  type        = map(string)
  description = "Contains values for the cidr block and AZ of each subnet"
}

variable "vpc_name" {
  type        = string
  description = "Name for the vpc"
}
