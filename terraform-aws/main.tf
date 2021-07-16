provider "aws" {
  //AWS CLI profile
  profile = "terraform"
  region  = "us-east-1"
}


terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "tf-backend-lklv"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
