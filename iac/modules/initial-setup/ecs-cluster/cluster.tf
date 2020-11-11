resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
  capacity_providers = [
  "FARGATE_SPOT"]

  setting {
    name  = "containerInsights"
    value = var.enable_container_insight == true ? "enabled" : "disabled"
  }
}
