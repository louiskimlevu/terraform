resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NAT_gateway"
  }
}

resource "aws_eip" "nat_gw_eip" {
  vpc = true
}
