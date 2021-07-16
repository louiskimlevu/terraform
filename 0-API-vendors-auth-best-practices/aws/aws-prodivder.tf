/*
2 options
`AWS_PROFILE=default && printenv | grep AWS_PROFILE && aws configure list-profiles`
`aws configure --profile terraform `
-> set ak,sak
`AWS_PROFILE=terraform && printenv | grep AWS_PROFILE && aws configure list`
For listing windows envs -> set, ex: `set | findstr "AWS_PROFILE"`
*/

provider "aws"{
    region = "us-east-1"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-lklv-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}