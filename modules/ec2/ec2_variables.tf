variable "ami_id" {
  description = "AMI ID for the setup-server instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID (public-a) for the setup-server"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs: SSH, ALB, Web"
  type        = list(string)
}

variable "efs_mount_dns" {
  description = "DNS or mount target address for EFS (wp-efs)"
  type        = string
}

variable "region" {
  description = "AWS region for EFS DNS suffix"
  type        = string
}

variable "db_endpoint" {
  description = "RDS endpoint DNS name"
  type        = string
}

variable "db_name" {
  description = "WordPress database name"
  type        = string
}

variable "db_user" {
  description = "WordPress DB user"
  type        = string
}

variable "db_password" {
  description = "WordPress DB user password"
  type        = string
  sensitive   = true
}