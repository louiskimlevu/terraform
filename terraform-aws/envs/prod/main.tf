terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  profile             = "default"
  region              = "us-east-1"
  allowed_account_ids = var.allowed_account_ids
}

