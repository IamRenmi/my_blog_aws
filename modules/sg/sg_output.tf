output "alb_sg_id" {
  description = "Security Group ID for ALB"
  value       = aws_security_group.alb.id
}

output "ssh_sg_id" {
  description = "Security Group ID for SSH access"
  value       = aws_security_group.ssh.id
}

output "web_sg_id" {
  description = "Security Group ID for web servers"
  value       = aws_security_group.web.id
}

output "db_sg_id" {
  description = "Security Group ID for database"
  value       = aws_security_group.db.id
}

output "efs_sg_id" {
  description = "Security Group ID for EFS"
  value       = aws_security_group.efs.id
}