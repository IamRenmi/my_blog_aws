# region
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

# env
variable "environment" {
  description = "Deployment environment label (e.g., dev, test)"
  type        = string
  default     = "dev"
}

# VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "48.0.0.0/16"
}
variable "public_subnets" {
  description = "Map of public subnet names to CIDR blocks"
  type        = map(string)
  default = {
    "public-a" = "48.0.1.0/24"
    "public-b" = "48.0.2.0/24"
  }
}
variable "app_subnets" {
  description = "Map of app subnet names to CIDR blocks"
  type        = map(string)
  default = {
    "app-a" = "48.0.3.0/24"
    "app-b" = "48.0.4.0/24"
  }
}
variable "data_subnets" {
  description = "Map of data subnet names to CIDR blocks"
  type        = map(string)
  default = {
    "data-a" = "48.0.5.0/24"
    "data-b" = "48.0.6.0/24"
  }
}
variable "subnet_azs" {
  description = "Map of subnet names to availability zones"
  type        = map(string)
  default = {
    "public-a" = "eu-west-2a"
    "public-b" = "eu-west-2b"
    "app-a"    = "eu-west-2a"
    "app-b"    = "eu-west-2b"
    "data-a"   = "eu-west-2a"
    "data-b"   = "eu-west-2b"
  }
}

# Security Group
variable "ssh_allowed_cidr" {
  description = "CIDR block (your IP) allowed to SSH into servers"
  type        = string
  default = "0.0.0.0/0"
}

# RDS
variable "db_password" {
  description = "RDS master user password"
  type        = string
  default     = "lab-password"
}

variable "db_username" {
  description = "RDS master user password"
  type        = string
  default = "admin"
}

variable "db_az" {
  description = "Availability zone for RDS single-AZ deployment"
  type        = string
  default     = "eu-west-2a"
}

variable "db_name" {
  description = "WordPress database name"
  type        = string
  default     = "wordpress"
}

variable "wp_db_username" {
  description = "WordPress database user"
  type        = string
  default     = "admin"
}