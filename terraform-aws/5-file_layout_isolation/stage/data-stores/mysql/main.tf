provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "tf-backend-lklv"
    key    = "5-file-layout-isolation/stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

# Get the latest Amazon Linux AMI
data "aws_ami" "amazon_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database"
  username            = "admin"
  password            = "password"
  skip_final_snapshot = "true"
}
