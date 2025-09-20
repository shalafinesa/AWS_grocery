/*
variable "ami_id" {
  type        = string
  description = "AMI-ID for EC2-instances in the Auto Scaling Group"
}

variable "instance_type" {
  type        = string
  description = "EC2-instance-type(eg. t2.micro)"
}

variable "key_name" {
  type        = string
  description = "Name of SSH-keypairs for EC2 access"
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM Instance Profile Name for EC2-access permissions"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of Subnets where EC2 instances are being launched"
}

variable "ec2_sg_ids" {
  type        = list(string)
  description = "List of Security Group IDs for EC2-Instances"
}

variable "target_group_arn" {
  type        = string
  description = "ARN of ALB Target Group for Load Balancer"
}

variable "user_data" {
  type        = string
  default     = ""
  description = "Optional script for User Data"
}
*/