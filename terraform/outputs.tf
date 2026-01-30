output "private_ips" {
  description = "Private IP addresses of the created EC2 instances"
  value       = aws_instance.servers[*].private_ip
}
