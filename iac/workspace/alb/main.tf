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
    key            = "alb"
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

module "alb" {
  source = "../../modules/alb"

  alb_name = "bice-vida-alb"
  vpc_id   = data.aws_vpc.vpc.id
}
