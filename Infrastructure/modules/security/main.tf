# Security Group for EC2 instances: Allows SSH access from a specified IP
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-ssh"
  description = "Allow SSH from my IP"
  vpc_id      = var.vpc_id

  # Incoming SSH access (port 22) only allowed from the IP defined in ssh_cidr
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }
  # Outgoing data traffic fully permitted
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "ec2-sg" }
}

# Security group for the RDS database: Allows PostgreSQL access only from EC2 security group
resource "aws_security_group" "rds_sg" {
  name        = "rds-access"
  description = "Allow Postgres from EC2"
  vpc_id      = var.vpc_id

  # Inbound access to port 5432 (PostgreSQL) only allowed from EC2-SG
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# Security Group for the Application Load Balancer: Allows HTTP traffic from anywhere
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP traffic for ALB"
  vpc_id      = var.vpc_id

  # HTTP access (port 80) allowed for all IPs (publicly accessible)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}