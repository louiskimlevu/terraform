resource "aws_vpc" "vpc_tf" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name       = "vpc_tf"
    Managed_by = "terraform"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_tf.id

  tags = {
    Name       = "igw"
    Managed_by = "terraform"
  }
}
