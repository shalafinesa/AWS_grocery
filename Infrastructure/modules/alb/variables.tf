# Allows you to pass the ID of an existing VPC dynamically (e.g. from the network module) instead of writing it permanently in the code.
variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

# This allows you to pass a list of subnets, depending on the environment
variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "az_public-a" {
  default = "eu-central-1a"
  description = "First public subnet AZ"
}

variable "az_public-b" {
  default = "eu-central-1b"
  description = "Second public subnet AZ"
}

# Allows you to assign a specific security group to the ALB - and to change it easily if required.
variable "alb_sg_id" {
  type        = string
  description = "Security Group ID for ALB"
}