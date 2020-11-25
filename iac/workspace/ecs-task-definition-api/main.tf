terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.14"
    }
  }

  backend "s3" {
    profile        = "bice-vida"
    bucket         = "bice-vida-terraform-remote-state-bucket"
    key            = "ecs-task-definition-api"
    dynamodb_table = "terraform_lock_table"
    region         = "us-east-2"
    encrypt        = true
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "bice-vida"
}

data "aws_ecr_repository" "repository" {
  name = "api-ecr-repository"
}

data "aws_iam_role" "ecsTaskExecutionRole" {
  name = "ecsTaskExecutionRole"
}

module "ecs_service_api" {
  source = "../../modules/ecs-task-definition"

  region = "us-east-2"

  name                   = "api"
  port                   = 8080
  container_cpu_units    = 256
  container_memory_units = 512
  execution_role_arn     = data.aws_iam_role.ecsTaskExecutionRole.arn
  ecr_repository_url     = data.aws_ecr_repository.repository.repository_url
}