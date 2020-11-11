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
    key            = "terraform-remote-state"
    dynamodb_table = "terraform_lock_table"
    region         = "us-east-2"
    encrypt        = true
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "bice-vida"
}

module "terraform_remote_state" {
  source = "../../modules/initial-setup/terraform-remote-state"

  bucket_name = "bice-vida-terraform-remote-state-bucket"
}
