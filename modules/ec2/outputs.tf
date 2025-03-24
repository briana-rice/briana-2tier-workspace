output "ec2_public_ips" {
  value = aws_instance.webserver[*].public_ip
}

output "web_sg_id" {
  value = aws_security_group.web_sg.id
}
