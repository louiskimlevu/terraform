
terraform {
  required_version = ">= 0.12.26"
}

provider "aws" {
  region = "us-east-1"
}



# Once the s3 bucket and dynamodb is setup
# Uncomment and then run in order to set the new backend and copy local state to s3: terraform init 
################################################################
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "tf-backend-lklv"
    key    = "terraform.tfstate"
    region = "us-east-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
