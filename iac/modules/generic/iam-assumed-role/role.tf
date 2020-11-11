resource "aws_iam_role" "role" {
  name                  = var.role_name
  force_detach_policies = true

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "${var.service_to_assume_role}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
