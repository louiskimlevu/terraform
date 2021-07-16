
resource "aws_launch_configuration" "lc" {
  name                 = "lc"
  image_id             = "ami-04d29b6f966df1537"
  instance_type        = "t2.micro"
  security_groups      = [aws_security_group.security_group_asg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_access_ssm_instance_profile.id
  user_data            = <<-EOF
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
              echo "Hello this is: " > index.html
              curl http://169.254.169.254/latest/meta-data/hostname >> index.html
              EOF

  # replace the order
  lifecycle {
    create_before_destroy = true
  }


}

resource "aws_autoscaling_group" "asg" {
  name                 = "asg"
  launch_configuration = aws_launch_configuration.lc.id
  min_size             = 2
  max_size             = 10
  vpc_zone_identifier  = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]
  health_check_type    = "ELB"
  target_group_arns    = [aws_lb_target_group.lb_target_group_asg.arn]


  tag {
    key                 = "Managed_by"
    value               = "terraform"
    propagate_at_launch = true
  }
}
