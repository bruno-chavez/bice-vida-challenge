module "ecs_task_role" {
  source = "../generic/iam-assumed-role"

  role_name              = "ecs-task-${var.name}-role"
  service_to_assume_role = "ecs-tasks.amazonaws.com"
}

resource "aws_iam_role_policy" "task_role_policy" {
  role = module.ecs_task_role.id

  name   = "ecs-task-${var.name}-role-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": ["*"],
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        }
    ]
}
EOF
}
