# Returns the ID of the EC2 instance.
output "instance_id" {
  description = "ID of EC2-Instance"
  value       = aws_instance.grocery_ec2.id
}

# Returns the public IP address of the instance.
output "public_ip" {
  description = "Public IP of the EC2-Instance"
  value       = aws_instance.grocery_ec2.public_ip
}

# Returns the private IP address of the instance (within the VPC).
# Important for internal communication - e.g. if other AWS resources (such as RDS) are to reach this instance.
output "private_ip" {
  description = "Private IP dof the EC2-Instance"
  value       = aws_instance.grocery_ec2.private_ip
}
