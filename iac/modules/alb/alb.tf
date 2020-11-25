data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id
}

resource "aws_alb" "alb" {
  name               = var.alb_name
  load_balancer_type = "application"
  enable_http2       = true
  internal           = false

  security_groups = [
  module.security_group.this_security_group_id]
  subnets = data.aws_subnet_ids.subnets.ids
}
