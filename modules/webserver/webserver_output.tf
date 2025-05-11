output "webserver_id" {
  description = "ID of the webserver instance"
  value       = aws_instance.webserver.id
}

output "webserver_private_ip" {
  description = "Private IP of the webserver instance"
  value       = aws_instance.webserver.private_ip
}