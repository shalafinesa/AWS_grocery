output "ec2_id" {
  value = aws_instance.grocery_ec2.id
}

output "ec2_public_ip" {
  value = aws_instance.grocery_ec2.public_ip
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "instance_id" {
  value = aws_instance.grocery_ec2.id
}

output "private_ip" {
  value = aws_instance.grocery_ec2.private_ip
}


