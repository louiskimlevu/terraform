/*
    aws ec2 describe-instances \
    --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
    --output table
    */

provider "aws" {
region="us-east-1"
}
resource "aws_instance" "vm" {
  ami           = "ami-0dc2d3e4c0f9ebd18"

instance_type = "t2.micro"
  tags = {
    Name = "my-first-tf-node"
  }
}
