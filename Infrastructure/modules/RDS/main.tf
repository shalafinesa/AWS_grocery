resource "aws_db_instance" "grocery_db" {
  identifier             = var.db_identifier
  username               = var.db_username
  password               = var.db_password
  allocated_storage      = var.db_allocated_storage
  instance_class         = var.db_instance_class
  engine                 = var.db_engine
  engine_version         = "14.19"
  vpc_security_group_ids = var.db_security_group_ids


  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name = aws_db_subnet_group.main.name


  tags = {
    Name = var.db_identifier
  }
}


# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow access to RDS from EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]  # only EC2 can access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

