output "rds_instance_id" {
  description = "ID of RDS-Instance"
  value       = aws_db_instance.rds_instance.id
}

output "db_endpoint" {
  description = "Endpoint of RDS-Instance"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_port" {
  description = "Port of RDS-Instance"
  value       = aws_db_instance.rds_instance.port
}

output "db_subnet_group_name" {
  description = "Name of the created DB subnet group"
  value       = aws_db_subnet_group.rds_subnet_group.name
}