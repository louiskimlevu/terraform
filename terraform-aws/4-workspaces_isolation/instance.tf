
# Get the latest Amazon Linux AMI
data "aws_ami" "amazon_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
}


resource "aws_instance" "ec2_ws" {
  ami           = data.aws_ami.amazon_ami.id
  instance_type = "t2.micro"

  tags = {
    Name       = "ec2_${terraform.workspace}"
    Managed_by = "terraform"
  }
}
