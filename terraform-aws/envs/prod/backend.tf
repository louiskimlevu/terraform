terraform {
  backend "s3" {
    bucket         = "tf-backend-lklv"
    region         = "us-east-1"
    key            = "prod/terraform.tfstate"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
    # ...
  }
}
