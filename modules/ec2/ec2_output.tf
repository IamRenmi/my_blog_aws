output "instance_id" {
  description = "EC2 setup-server instance ID"
  value       = aws_instance.setup_server.id
}

output "public_ip" {
  description = "Public IP address of setup-server"
  value       = aws_instance.setup_server.public_ip
}