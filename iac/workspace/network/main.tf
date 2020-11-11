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
    key            = "network"
    dynamodb_table = "terraform_lock_table"
    region         = "us-east-2"
    encrypt        = true
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "bice-vida"
}

module "network" {
  source = "../../modules/initial-setup/network"

  vpc_name = "bice-vida-vpc"
  subnets = {
    "us-east-2a" = "10.0.1.0/24"
    "us-east-2b" = "10.0.2.0/24"
    "us-east-2c" = "10.0.3.0/24"
  }
}
