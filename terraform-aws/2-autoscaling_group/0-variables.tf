data "aws_availability_zones" "all" {}
data "aws_vpc" "default" {
  default = true
}
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}


variable "vpc_cidr" {
  description = "vpc_cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "public_subnet_cidr"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets_cidr" {
  description = "private_subnets_cidr"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
