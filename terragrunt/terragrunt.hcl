
remote_state {
  backend = "s3"
  generate = {
    path      = "terragrunt-backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terragrunt-backend-lklv"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-up-and-running-locks"
  }
}


generate "provider" {
  path = "terragrunt-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = "arn:aws:iam::759744877037:role/terragrunt"
  }
}
EOF
}