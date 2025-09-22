# Shows you the public IP address of your EC2 instance in your terminal directly after deployment.
output "ec2_public_ip" {
  description = "Public IP of EC2 instance"
  value       = module.ec2.public_ip
}

# Gives you the host name of the RDS database instance.
output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = module.rds.db_endpoint
}

# You can retrieve these outputs any time with
# terraform output ec2_public_ip
# terraform output rds_endpoint
# terraform output (shows all outputs at once)