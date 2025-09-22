# Creates a subnet group for RDS, consisting of several private subnets.
# This group defines where the RDS instance may run within the VPC.
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids  # List of private subnets (e.g. in two AZs for resilience)
  tags = {
    Name = "RDSSubnetGroup"
  }
}

# Creates a PostgreSQL database instance within the specified subnet group.
# The DB is not publicly accessible and is protected by a security group.
# The security group can be found in the module "security".
resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13.15"
  instance_class       = var.rds_instance_class
  username             = var.rds_username
  password             = var.rds_password  # Master password (never hardcode!)
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot  = true
  tags = { Name = "TerraformRDS" }
}

