provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "tf-backend-lklv"
    key    = "6/prod/terraform.tfstate"
    region = "us-east-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

module "vpc_prod" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name

}
