resource "aws_ecs_task_definition" "task_definition" {
  family = "${var.name}-task-definition"
  requires_compatibilities = [
  "FARGATE"]
  network_mode = "awsvpc"

  memory = var.container_memory_units
  cpu    = var.container_cpu_units

  task_role_arn      = module.ecs_task_role.arn
  execution_role_arn = var.execution_role_arn

  container_definitions = <<EOF
[
  {
    "name": "${var.name}-container",
    "image": "${var.ecr_repository_url}:0.0.1",
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${var.port}
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
         "awslogs-group": "${local.log_group_name}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
EOF
}
