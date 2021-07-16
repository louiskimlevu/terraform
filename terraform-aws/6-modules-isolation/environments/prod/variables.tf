# vpc module
variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "aws_region" {
  default = "us-east-1"
}
