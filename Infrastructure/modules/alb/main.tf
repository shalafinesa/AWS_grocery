# Creates an application load balancer (ALB) that is publicly accessible
resource "aws_lb" "grocery-mate_alb" {
  name               = "grocery-mate-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [var.alb_sg_id]

  tags = {
    Name = "AppALB"
  }
}

# Target group to which the ALB forwards requests - here port 80 (HTTP) for the app
resource "aws_lb_target_group" "grocery-mate_tg" {
  name     = "grocery-mate-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

# Health Check checks whether EC2 instances are available
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# Listener on port 80 - receives HTTP requests and forwards them to the target group
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.grocery-mate_alb.arn
  port              = 80
  protocol          = "HTTP"

# Forwarding to the target group
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grocery-mate_tg.arn
  }
}