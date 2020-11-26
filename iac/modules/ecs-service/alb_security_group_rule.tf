resource "aws_security_group_rule" "alb_egress_security_group_rule" {
  security_group_id = var.alb_security_group_id
  protocol          = "tcp"
  type              = "egress"

  from_port                = var.port
  to_port                  = var.port
  source_security_group_id = module.security_group.this_security_group_id
  description              = "access to ${var.name} service"
}
