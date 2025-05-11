output "efs_id" {
  description = "EFS File System ID"
  value       = aws_efs_file_system.this.id
}

output "mount_target_ids" {
  description = "List of EFS Mount Target IDs"
  value       = values(aws_efs_mount_target.this)[*].id
}