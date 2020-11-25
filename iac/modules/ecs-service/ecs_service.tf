data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id
}

resource "aws_ecs_service" "service" {
  name            = "${var.name}-service"
  cluster         = var.cluster_id
  task_definition = var.task_definition

  desired_count                      = 2
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds  = 30

  network_configuration {
    assign_public_ip = true
    subnets          = data.aws_subnet_ids.subnets.ids
    security_groups = [
    module.security_group.this_security_group_id]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.target_group.arn
    container_name   = "${var.name}-container"
    container_port   = var.port
  }

  lifecycle {
    ignore_changes = [
    desired_count]
  }
}
