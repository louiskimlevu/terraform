resource "aws_security_group" "security_group_asg" {
  name   = "security_group_asg"
  vpc_id = aws_vpc.vpc_tf.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Managed_by = "terraform"
  }
}

resource "aws_security_group_rule" "security_group_rule_asg_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.security_group_asg.id
}
resource "aws_security_group_rule" "security_group_rule_asg_allow_http" {
  type                     = "ingress"
  from_port                = var.server_port
  to_port                  = var.server_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.security_group_alb.id
  security_group_id        = aws_security_group.security_group_asg.id
}
resource "aws_security_group_rule" "security_group_rule_asg_allow_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.security_group_alb.id
  security_group_id        = aws_security_group.security_group_asg.id
}

resource "aws_security_group_rule" "security_group_rule_asg_allow_icmp" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.security_group_alb.id
  security_group_id        = aws_security_group.security_group_asg.id
}
