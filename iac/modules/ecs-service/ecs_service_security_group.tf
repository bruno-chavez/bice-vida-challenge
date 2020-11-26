module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  vpc_id = var.vpc_id

  name                   = "${var.name}-security-group"
  use_name_prefix        = false
  description            = "${var.name} security group"
  revoke_rules_on_delete = true

  egress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "internet access"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ingress_with_source_security_group_id = [
    {
      from_port                = var.port
      to_port                  = var.port
      protocol                 = "tcp"
      description              = "ecs alb access"
      source_security_group_id = var.alb_security_group_id
    }
  ]
}