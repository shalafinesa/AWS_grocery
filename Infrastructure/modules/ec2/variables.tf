variable "subnet_id" {
  description = "ID of the Subnet"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security Group IDs"
  type        = list(string)
}

variable "key_name" {
  description = "SSH Key Name"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile Name"
  type        = string
}