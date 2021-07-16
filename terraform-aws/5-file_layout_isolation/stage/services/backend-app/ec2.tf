
data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    # Replace this with your bucket name!
    bucket = "tf-backend-lklv"
    key    = "5-file-layout-isolation/stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "backend_instance" {

  ami                         = "ami-04d29b6f966df1537"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.ec2_access_ssm_instance_profile.id
  user_data                   = <<-EOF
              #!/bin/bash
              sudo su
              yum update -y
              yum install -y https://s3.us-east-1.amazonaws.com/amazon-ssm-us-east-1/latest/linux_amd64/amazon-ssm-agent.rpm
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent
              systemctl status amazon-ssm-agent
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              cd /var/www/html
              db_address="${data.terraform_remote_state.db.outputs.address}"
              db_port="${data.terraform_remote_state.db.outputs.port}"
              echo "Hello, World. DB is at $db_address:$db_port" >> index.html
              EOF
}
# Role for ec2 instances
resource "aws_iam_role" "ec2_access_ssm_role" {
  name = "ec2_access_ssm_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    Managed_by = "terraform"
  }
}


# Attach policy to Role
resource "aws_iam_policy_attachment" "iam_policy_attachment_AmazonSSMManagedInstanceCore" {
  name       = "iam_policy_attachment_AmazonSSMManagedInstanceCore"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  roles      = [aws_iam_role.ec2_access_ssm_role.name]
}

# EC2 instance profile
resource "aws_iam_instance_profile" "ec2_access_ssm_instance_profile" {
  name = "ec2_access_ssm_instance_profile"
  role = aws_iam_role.ec2_access_ssm_role.name
}
