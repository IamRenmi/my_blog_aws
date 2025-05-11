variable "ami_id" {
  description = "AMI ID for webserver instance"
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
  description = "Subnet ID for the webserver"
  type        = string
}

variable "subnet_name" {
  description = "Logical name of the subnet (e.g., 'a' or 'b')"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for webserver (webserver-sg)"
  type        = string
}

variable "efs_mount_dns" {
  description = "EFS FileSystem ID (fs-xxxx)"
  type        = string
}

variable "region" {
  description = "AWS region for EFS DNS suffix"
  type        = string
}
