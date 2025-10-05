# -----------------------------
# AWS Region
# -----------------------------
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

# -----------------------------
# EC2 Variables
# -----------------------------
variable "ec2_ami" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM profile for EC2"
  type        = string
  default     = null
}

# -----------------------------
# Bastion Variables
# -----------------------------
variable "bastion_ami" {
  description = "AMI ID for Bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for Bastion host"
  type        = string
  default     = "t3.micro"
}

variable "my_ip" {
  description = "Your public IP for SSH access to bastion host"
  type        = string
}


# -----------------------------
# RDS Variables
# -----------------------------
variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}


# -----------------------------
# ALB Variables
# -----------------------------

variable "alb_name" {
  description = "Application Load Balancer name"
  type        = string
  default     = "grocery-alb" 
}


variable "app_repo_url" {
  description = "Git repository URL for the app to deploy"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security group ID of the Bastion host to allow SSH access"
  type        = string
}

