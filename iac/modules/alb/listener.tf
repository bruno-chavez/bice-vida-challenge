resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.alb.arn

  protocol = "HTTP"
  port     = 80

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      status_code  = "500"
      message_body = jsonencode(
        {
          "error" = "no ecs service has registered tasks"
        }
      )
    }
  }
}
