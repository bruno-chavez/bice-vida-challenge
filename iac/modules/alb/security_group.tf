module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  vpc_id = var.vpc_id

  name                   = "${var.alb_name}-security-group"
  use_name_prefix        = false
  description            = "ecs alb security group"
  revoke_rules_on_delete = true

  ingress_cidr_blocks = [
  "0.0.0.0/0"]
  ingress_rules = [
  "http-80-tcp"]
}
