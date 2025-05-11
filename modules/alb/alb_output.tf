output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.wp_alb.arn
}

output "listener_arn" {
  description = "ARN of the HTTP listener"
  value       = aws_lb_listener.http.arn
}

output "target_group_arn" {
  description = "ARN of the target group wp-tg"
  value       = aws_lb_target_group.wp_tg.arn
}