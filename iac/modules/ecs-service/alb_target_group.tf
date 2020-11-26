resource "aws_alb_target_group" "target_group" {
  vpc_id = var.vpc_id

  name                 = "${var.name}-target-group"
  port                 = var.port
  protocol             = "HTTP"
  target_type          = "ip"
  deregistration_delay = 30

  health_check {
    path = "/health"
  }
}
