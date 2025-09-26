output "db_endpoint" {
  value = aws_db_instance.grocery_db.endpoint
}

output "db_id" {
  value = aws_db_instance.grocery_db.id
}
