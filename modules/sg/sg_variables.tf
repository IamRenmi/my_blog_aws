variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "ssh_source_cidr" {
  description = "CIDR block allowed to SSH (your IP)"
  type        = string
}


variable "tags" {
  description = "Map of tags to apply to all security groups"
  type        = map(string)
}