resource "aws_alb_listener_rule" "service_rule" {
  listener_arn = var.alb_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }

  condition {
    path_pattern {
      values = [
      var.path_pattern]
    }
  }
}
