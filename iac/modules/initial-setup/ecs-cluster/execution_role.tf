module "execution_role" {
  source                 = "../../generic/iam-assumed-role"
  role_name              = "ecsTaskExecutionRole"
  service_to_assume_role = "ecs-tasks.amazonaws.com"
}

resource "aws_iam_role_policy_attachment" "execution_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = module.execution_role.name
}
