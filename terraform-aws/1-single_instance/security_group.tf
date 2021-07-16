resource "aws_security_group" "security_group_ssh_http_icmp" {
  name = "security_group_ssh_http_icmp"
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

resource "aws_security_group_rule" "security_group_rule_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.security_group_ssh_http_icmp.id
}
resource "aws_security_group_rule" "security_group_rule_allow_http" {
  type              = "ingress"
  from_port         = var.server_port
  to_port           = var.server_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_ssh_http_icmp.id
}
resource "aws_security_group_rule" "security_group_rule_allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_ssh_http_icmp.id
}

resource "aws_security_group_rule" "security_group_rule_allow_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_ssh_http_icmp.id
}


