

# Role for ec2 instances
resource "aws_iam_role" "iam_role_ssm" {
  name = "iam_role_ssm"

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
  roles      = [aws_iam_role.iam_role_ssm.name]
}


resource "aws_iam_instance_profile" "iam_instance_profile_ssm" {
  name = "iam_instance_profile_ssm"
  role = aws_iam_role.iam_role_ssm.name
}
