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
    key            = "ecs-service-api"
    dynamodb_table = "terraform_lock_table"
    region         = "us-east-2"
    encrypt        = true
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "bice-vida"
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "bice-vida-vpc"
  }
}

data "aws_ecs_cluster" "cluster" {
  cluster_name = "bice-vida-ecs-cluster"
}

data "aws_alb" "alb" {
  name = "bice-vida-alb"
}

data "aws_alb_listener" "alb_listener" {
  load_balancer_arn = data.aws_alb.alb.arn
  port              = 80
}

data "aws_security_group" "alb_sg" {
  name = "bice-vida-alb-security-group"
}

data "aws_ecs_task_definition" "api" {
  task_definition = "api-task-definition"
}

module "ecs_service_api" {
  source = "../../modules/ecs-service"

  vpc_id = data.aws_vpc.vpc.id

  cluster_id            = data.aws_ecs_cluster.cluster.id
  alb_listener_arn      = data.aws_alb_listener.alb_listener.arn
  task_definition       = data.aws_ecs_task_definition.api.task_definition
  alb_security_group_id = data.aws_security_group.alb_sg.id

  name         = "api"
  path_pattern = "/api*"
  port         = 8080
}