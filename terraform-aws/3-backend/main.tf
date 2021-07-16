
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
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}
output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}
################################################################
