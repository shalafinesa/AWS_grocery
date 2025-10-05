output "db_endpoint" {
  value = aws_db_instance.grocery_db.endpoint
}

output "db_id" {
  value = aws_db_instance.grocery_db.id
}

# Output RDS SG ID
output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.main.name
}
