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
