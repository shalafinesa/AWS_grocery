variable "instance_name" {}
variable "instance_type" {}
variable "ami" {}
variable "key_name" {}
variable "subnet_id" {}
variable "security_group_ids" {
  type = list(string)
}
variable "iam_instance_profile" {
  default = null
}
