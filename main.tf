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
# Security Group for EC2
# -----------------------------
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow access to EC2 from ALB only"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [module.alb.alb_sg_id] # only ALB HTTP
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [module.alb.alb_sg_id] # only ALB HTTPS
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [var.bastion_sg_id]  # SSH from your IP only
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# Security Group for RDS
# -----------------------------
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow access to RDS from EC2 only"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id] # only EC2 SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# Bastion Host in Public Subnet
# -----------------------------
module "bastion" {
  source        = "./Infrastructure/modules/bastion"
  ami           = var.bastion_ami
  instance_type = var.bastion_instance_type
  subnet_id     = module.vpc.public_subnet_ids[0]
  key_name      = var.key_name
  allowed_ip    = var.my_ip
  vpc_id        = module.vpc.vpc_id
  my_ip         = var.my_ip 
}

# -----------------------------
# Private EC2 Module (move to private subnet)
# -----------------------------
module "ec2" {
  source = "./Infrastructure/modules/ec2"

  instance_name        = "grocery-ec2"
  instance_type        = "t3.micro"
  ami                  = var.ec2_ami
  key_name             = var.key_name
  subnet_id            = module.vpc.private_subnet_ids[0]
  security_group_ids   = [aws_security_group.ec2_sg.id]
  alb_sg_id            = module.alb.alb_sg_id         # NEW: allow ALB ingress
  bastion_sg_id        = module.bastion.bastion_sg_id # NEW: allow SSH from Bastion
  iam_instance_profile = var.iam_instance_profile
  app_repo_url         = var.app_repo_url
  my_ip                = "95.223.228.20/32"
  vpc_id               = module.vpc.vpc_id
}

# -----------------------------
# RDS Module (using variable for password)
# -----------------------------
module "rds" {
  source = "./Infrastructure/modules/RDS"

  db_identifier          = "grocery-db"
  db_name                = "grocery"
  db_username            = var.db_user
  db_password            = var.db_password
  db_allocated_storage   = 20
  db_instance_class      = "db.t3.micro"
  db_engine              = "postgres"
  db_engine_version      = "14.19"
  db_security_group_ids  = [aws_security_group.rds_sg.id]
  ec2_sg_id              = aws_security_group.ec2_sg.id
  db_publicly_accessible = false
  private_subnet_ids     = module.vpc.private_subnet_ids
  vpc_id                 = module.vpc.vpc_id



}

# -----------------------------
# ALB Module
# -----------------------------
module "alb" {
  source         = "./Infrastructure/modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  ec2_ids        = [module.ec2.instance_id]
  alb_name       = "grocery-alb"
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

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "private_ec2_id" {
  value = module.ec2.instance_id
}

