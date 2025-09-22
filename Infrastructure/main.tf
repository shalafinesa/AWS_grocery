# This Terraform root module orchestrates a complete cloud setup for an e-commerce application (GroceryMate),
# consisting of modularized components for network, security, compute, database and more.
# The goal is to provide infrastructure as code in a clearly structured, reusable and maintainable way.

# Initialize Terraform
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# IAM roles and profiles (e.g. for EC2 Instance Connect)
# module call "iam"
module "iam" {
  source = "./modules/iam"
}

# S3 bucket for images (e.g. avatars, product images)
# module call "s3"
module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = var.picture_bucket_name
  environment    = var.environment
}

# VPC, subnets & Internet gateway (basis for network communication)
#module call "network"
module "network" {
  source     = "./modules/network"
  aws_region = var.aws_region
  az_public_a   = var.az_public-a
  az_public_b   = var.az_public-b
  az_private_a   = var.az_private_a
  az_private_b   = var.az_private_b
}

# Security groups for EC2, RDS, ALB etc.
#module call "security"
module "security" {
  source   = "./modules/security"
  vpc_id   = module.network.vpc_id
  ec2_sg_id = module.security.ec2_sg_id
  ssh_cidr   = var.ssh_cidr
}

# Public EC2 instance for the GroceryMate-app)
# module call "ec2"
module "ec2" {
  source                 = "./modules/ec2"
  subnet_id              = module.network.public_subnet_ids[0] # This gives it the first public subnet from the list.
  vpc_security_group_ids = [module.security.ec2_sg_id]
  iam_instance_profile   = module.iam.ec2_profile_name
  key_name               = var.key_name
}

# RDS PostgreSQL instance (persistent data storage)
# module call "rds"
module "rds" {
  source             = "./modules/rds"
  rds_instance_class = var.rds_instance_class
  rds_username       = var.rds_username
  rds_password       = var.rds_password
  subnet_ids         = [module.network.private_a_id, module.network.private_b_id]
  ec2_sg_id          = module.security.ec2_sg_id
  vpc_id             = module.network.vpc_id
  rds_sg_id          = module.security.rds_sg_id
}

# Application load balancer (for HTTP traffic and scaling targets)
# module call "alb"
module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnet_ids
  alb_sg_id      = module.security.alb_sg_id
}

/*
# Autoscaling Group for high availability & scaling of the app server
# module call "asg"
module "asg" {
  source               = "./modules/asg"
  ami_id               = "ami-0b74f796d330ab49c"
  instance_type        = "t2.micro"
  key_name             = var.key_name
  iam_instance_profile = module.iam.ec2_profile_name
  public_subnets       = module.network.public_subnet_ids
  ec2_sg_ids           = [module.security.ec2_sg_id]
  target_group_arn     = module.alb.target_group_arn
  user_data            = file("${path.module}/scripts/user_data.sh")
}
*/