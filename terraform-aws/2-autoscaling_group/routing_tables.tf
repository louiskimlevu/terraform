
# Public
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc_tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Managed_by = "terraform"
  }
}

resource "aws_route_table_association" "rt_public_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.rt_public.id
}
resource "aws_route_table_association" "rt_public_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.rt_public.id
}
resource "aws_route_table_association" "rt_public_association_3" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.rt_public.id
}

# Private
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc_tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Managed_by = "terraform"
  }
}

resource "aws_route_table_association" "rt_private_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.rt_private.id
}
resource "aws_route_table_association" "rt_private_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.rt_private.id
}
resource "aws_route_table_association" "rt_private_association_3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.rt_private.id
}
