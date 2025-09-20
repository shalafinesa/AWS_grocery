variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "az_public_a" {
  description = "Availability Zone for public subnet A"
  type        = string
  default     = "eu-central-1a"
}

variable "az_public_b" {
  description = "Availability Zone for public subnet B"
  type        = string
  default     = "eu-central-1b"
}

variable "az_private_a" {
  description = "Availability Zone for private subnet A"
  type        = string
  default     = "eu-central-1a"
}

variable "az_private_b" {
  description = "Availability Zone for private subnet B"
  type        = string
  default     = "eu-central-1b"
}