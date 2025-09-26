resource "aws_db_instance" "grocery_db" {
  identifier             = var.db_identifier                
  username               = var.db_username          
  password               = var.db_password          
  allocated_storage      = var.db_allocated_storage 
  instance_class         = var.db_instance_class    
  engine                 = var.db_engine            
  engine_version         = "14.19"  
  vpc_security_group_ids = var.db_security_group_ids 
  db_subnet_group_name   = aws_db_subnet_group.main.name
  publicly_accessible    = var.db_publicly_accessible
  skip_final_snapshot    = true

  tags = {
    Name = var.db_name
  }
}
