variable "vpc_id" {
  description = "VPC ID for ALB and target group"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security Group ID for the ALB"
  type        = string
}

variable "target_ids" {
  description = "Map of logical names to EC2 instance IDs to register"
  type        = map(string)
}

variable "protocol" {
  description = "Protocol for ALB listener and target group"
  type        = string
  default     = "HTTP"
}

variable "port" {
  description = "Port for ALB listener and target group"
  type        = number
  default     = 80
}

variable "health_check" {
  description = "Health check configuration for the target group"
  type = object({
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
    matcher             = string
  })
  default = {
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-302"
  }
}