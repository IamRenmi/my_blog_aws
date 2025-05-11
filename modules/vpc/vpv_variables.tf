variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnet names to CIDR blocks"
  type        = map(string)
}

variable "app_subnets" {
  description = "Map of application subnet names to CIDR blocks"
  type        = map(string)
}

variable "data_subnets" {
  description = "Map of data subnet names to CIDR blocks"
  type        = map(string)
}

variable "subnet_azs" {
  description = "Map of subnet names to availability zones"
  type        = map(string)
}