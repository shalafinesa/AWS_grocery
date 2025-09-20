variable "vpc_id" {
  description = "ID of VPC"
  type        = string
}

variable "ec2_sg_id" {
  description = "EC2 SG ID (for RDS-access)"
  type        = string
}

variable "ssh_cidr" {
  type        = string
  description = "CIDR-Block for SSH-access"  # write preferred IP address (e.g. your IP) in terraform.tfvars file
}