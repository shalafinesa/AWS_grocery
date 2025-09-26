provider "aws" {
  region  = "eu-north-1"
  profile = "my-sso-profile"
}

# -----------------------------
# VPC Module
# -----------------------------
module "vpc" {
  source = "./Infrastructure/modules/VPC"

  azs                  = ["eu-north-1a", "eu-north-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

# -----------------------------
# Security Group for RDS
# -----------------------------
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow access to RDS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # allow only from VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# RDS Module
# -----------------------------
module "rds" {
  source = "./Infrastructure/modules/RDS"

   db_identifier          = "grocery-db"
  db_name                = "grocery"
  db_username            = "groceryadmin"
  db_password            = "YourSecurePassword"
  db_allocated_storage   = 20
  db_instance_class      = "db.t3.micro"
  db_engine              = "postgres"
  db_engine_version      = "14.19"
  db_security_group_ids  = [aws_security_group.rds_sg.id]
  db_publicly_accessible = false
  private_subnet_ids     = module.vpc.private_subnet_ids
}

# -----------------------------
# EC2 Module
# -----------------------------
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow access to EC2"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


module "ec2" {
  source = "./Infrastructure/modules/ec2"

  instance_name      = "grocery-ec2"
  instance_type      = "t3.micro"
  ami                = "ami-038896afdd7b6a879"
  key_name           = "awsgrocery"
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [aws_security_group.ec2_sg.id] 
  iam_instance_profile = null   # or an existing IAM profile if needed
}


# -----------------------------
# Outputs
# -----------------------------
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "ec2_public_ip" {
  value = module.ec2.instance_public_ip
}
