output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_ec2_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = module.webserver.ec2_public_ips
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.rds_endpoint
}
