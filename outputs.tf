output "server_name" {
  description = "Name of the server"
  value       = aws_instance.server.id
}
