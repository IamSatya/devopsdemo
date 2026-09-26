# Terraform Output Definitions

output "instance_id" {
  description = "ID of the provisioned EC2 instance"
  value       = aws_instance.web_server.id
}

output "public_ip" {
  description = "Elastic IP address attached to the web server"
  value       = aws_eip.web_eip.public_ip
}

output "public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_eip.web_eip.public_dns
}

output "website_url" {
  description = "Public URL for accessing the Healthcare website"
  value       = "http://${aws_eip.web_eip.public_ip}"
}

output "security_group_id" {
  description = "ID of the Web Security Group"
  value       = aws_security_group.web_sg.id
}
