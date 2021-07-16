resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc_tf.id
  cidr_block              = var.public_subnets_cidr[0]
  availability_zone_id    = data.aws_availability_zones.all.zone_ids[0]
  map_public_ip_on_launch = "true"

  tags = {
    Name       = "public_subnet_1"
    Managed_by = "terraform"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc_tf.id
  cidr_block              = var.public_subnets_cidr[1]
  availability_zone_id    = data.aws_availability_zones.all.zone_ids[1]
  map_public_ip_on_launch = "true"

  tags = {
    Name       = "public_subnet_2"
    Managed_by = "terraform"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.vpc_tf.id
  cidr_block              = var.public_subnets_cidr[2]
  availability_zone_id    = data.aws_availability_zones.all.zone_ids[2]
  map_public_ip_on_launch = "true"
  tags = {
    Name       = "public_subnet_3"
    Managed_by = "terraform"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc_tf.id
  cidr_block              = var.private_subnets_cidr[0]
  availability_zone_id    = data.aws_availability_zones.all.zone_ids[0]
  map_public_ip_on_launch = "false"
  tags = {
    Name       = "private_subnet_1"
    Managed_by = "terraform"
  }
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc_tf.id
  cidr_block              = var.private_subnets_cidr[1]
  availability_zone_id    = data.aws_availability_zones.all.zone_ids[1]
  map_public_ip_on_launch = "false"
  tags = {
    Name       = "private_subnet_2"
    Managed_by = "terraform"
  }
}
resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.vpc_tf.id
  cidr_block              = var.private_subnets_cidr[2]
  availability_zone_id    = data.aws_availability_zones.all.zone_ids[2]
  map_public_ip_on_launch = "false"
  tags = {
    Name       = "private_subnet_3"
    Managed_by = "terraform"
  }
}
