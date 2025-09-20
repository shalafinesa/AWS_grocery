variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "az_public-a" {
  description = "First AZ for public subnet"
  type        = string
}

variable "az_public-b" {
  description = "Second AZ for public subnet"
  type        = string
}

variable "az_private_a" {
  description = "AZ for private subnet A"
  type        = string
}

variable "az_private_b" {
  description = "AZ for private subnet B"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR block allowed to SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "rds_instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_db_name" {
  description = "Database name"
  type        = string
}

variable "rds_username" {
  description = "Master username"
  type        = string
}

variable "rds_password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "picture_bucket_name" {
  type        = string
  description = "Name of Picture-Bucket"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment Environment"
}


