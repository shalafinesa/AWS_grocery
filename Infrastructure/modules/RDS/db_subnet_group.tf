resource "aws_db_subnet_group" "main" {
  name       = "grocery-db-subnet-group-2"   
  subnet_ids = var.private_subnet_ids         
  tags = { Name = "grocery-db-subnet-group-2" }
}
