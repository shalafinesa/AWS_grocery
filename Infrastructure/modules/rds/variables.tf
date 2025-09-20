variable "rds_instance_class" {
  description = "RDS-instance-class"
  type        = string
}

variable "rds_username" {
  description = "RDS-username"
  type        = string
}

variable "rds_password" {
  description = "RDS-password"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "Subnet-IDs for RDS"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "Security Group ID from EC2"
  type        = string
}

variable "vpc_id" {
  description = "ID of VPC"
  type        = string
}

variable "rds_sg_id" {
  description = "Security Group ID for RDS"
  type        = string
}