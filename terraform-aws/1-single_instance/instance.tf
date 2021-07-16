

resource "aws_instance" "instance" {
  ami                    = "ami-04d29b6f966df1537"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security_group_ssh_http_icmp.id]
  iam_instance_profile   = aws_iam_instance_profile.iam_instance_profile_ssm.name
  user_data              = <<-EOF
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
              echo "Hello LKLV" > index.html
              cd /etc/httpd/conf
              EOF
  tags = {
    Name        = "instance_demo"
    Environment = "production"
    Managed_by  = "terraform"
  }
}


