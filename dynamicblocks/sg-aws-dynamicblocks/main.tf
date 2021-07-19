provider "aws"{
    region="us-east-1"
}
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

variable "web_ingress"{
    type=map(object({
        port=number
        protocol=string
        cidr_blocks=list(string)
    }))

    default={
        "80"={
            port =90
            protocol ="tcp"
            cidr_blocks= ["0.0.0.0/0"]
        }
         "443"={
            port =443
            protocol ="tcp"
            cidr_blocks= ["0.0.0.0/0"]
        }
    }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress"{
    for_each= var.web_ingress
    content{
        description="TLS from VPC"
        from_port=ingress.value.port
        to_port=ingress.value.port
        protocol=ingress.value.protocol
        cidr_blocks=ingress.value.cidr_blocks
    }
    }
#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [aws_vpc.main.cidr_block]
#     ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}