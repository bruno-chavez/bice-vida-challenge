locals {
  log_group_name = "/ecs/${var.name}"
}

resource "aws_cloudwatch_log_group" "ecs_service_log_group" {
  name = local.log_group_name

  retention_in_days = 7
}