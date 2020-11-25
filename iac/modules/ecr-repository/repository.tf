resource "aws_ecr_repository" "repository" {
  name = var.name

  image_scanning_configuration {
    # we deactivate scans since we use scratch base images, which are not supported by ECR
    scan_on_push = false
  }
}

resource "aws_ecr_lifecycle_policy" "repo_lifecycle_policy" {
  repository = aws_ecr_repository.repository.name
  policy     = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "description": "Expires untagged images older than 7 days",
                "selection": {
                    "tagStatus": "untagged",
                    "countType": "sinceImagePushed",
                    "countUnit": "days",
                    "countNumber": 7
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
  EOF
}