# Outputs
output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}