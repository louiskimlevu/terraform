
resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security_group_alb.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id, aws_subnet.public_subnet_3.id]

  enable_deletion_protection = false

  tags = {
    Managed_by = "terraform"
  }
}

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.server_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group_asg.arn
  }
}
resource "aws_lb_target_group" "lb_target_group_asg" {
  name     = "tg"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_tf.id
  health_check {
    path     = "/"
    protocol = "HTTP"
    matcher  = "200"
  }
}
