# EC2 Instance Name (tag)
variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

# EC2 Instance Type
variable "instance_type" {
  description = "Type of EC2 instance (e.g., t3.micro)"
  type        = string
}

# AMI ID
variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

# Key pair for SSH access
variable "key_name" {
  description = "Key pair name to access EC2"
  type        = string
}

# Subnet ID where EC2 will be launched
variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

# Security Groups attached to EC2
variable "security_group_ids" {
  description = "List of Security Group IDs for EC2"
  type        = list(string)
}

# IAM instance profile (CloudWatch role)
variable "iam_instance_profile" {
  description = "IAM Instance Profile to attach (CloudWatch role)"
  type        = string
  default     = null
}

variable "alb_sg_id" {
  description = "Security group ID of the ALB"
  type        = string
}


variable "app_repo_url" {
  description = "Git repository URL to clone in user_data"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EC2 instance is deployed"
  type        = string
}

variable "my_ip" {
  description = "Your public IP with CIDR suffix"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security group ID of the Bastion host to allow SSH access"
  type        = string
}

