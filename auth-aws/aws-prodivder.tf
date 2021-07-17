/*
2 options
`AWS_PROFILE=default && printenv | grep AWS_PROFILE && aws configure list-profiles`
`aws configure --profile terraform `
-> set ak,sak
`AWS_PROFILE=terraform && printenv | grep AWS_PROFILE && aws configure list`
For listing windows envs -> set, ex: `set | findstr "AWS_PROFILE"`
*/

provider "aws" {
  alias  = "east"
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-lklv-tf-test-bucket"
  provider=aws.east
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}