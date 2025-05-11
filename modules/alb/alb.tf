# Application Load Balancer
resource "aws_lb" "wp_alb" {
  name               = "wp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnets
  ip_address_type    = "ipv4"
  enable_http2       = true
  tags = { Name = "wp-alb" }
}

# Target Group
resource "aws_lb_target_group" "wp_tg" {
  name             = "wp-tg"
  protocol         = var.protocol
  port             = var.port
  vpc_id           = var.vpc_id
  protocol_version = "HTTP1"

  health_check {
    enabled             = true
    interval            = var.health_check.interval
    timeout             = var.health_check.timeout
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
    matcher             = var.health_check.matcher
    port                = "traffic-port"
  }
}

# Listener forwarding HTTP:80 to target group
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.wp_alb.arn
  protocol          = var.protocol
  port              = var.port

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wp_tg.arn
  }
}

# Register EC2 instances in the target group
resource "aws_lb_target_group_attachment" "webservers" {
  for_each         = var.target_ids
  target_group_arn = aws_lb_target_group.wp_tg.arn
  target_id        = each.value
  port             = var.port
}