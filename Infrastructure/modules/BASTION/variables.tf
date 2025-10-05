variable "ami" {
  description = "AMI ID for Bastion host"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for Bastion host"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for Bastion host"
  type        = string
}

variable "key_name" {
  description = "Key pair name for Bastion host"
  type        = string
}

variable "allowed_ip" {
  description = "Your public IP to allow SSH access (e.g., 95.223.228.20/32)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the Bastion host will reside"
  type        = string
}

variable "my_ip" {
  description = "Your public IP for SSH access to Bastion"
  type        = string
}

