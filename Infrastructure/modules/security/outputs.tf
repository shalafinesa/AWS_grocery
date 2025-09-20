output "ec2_sg_id" {
  description = "Security Group ID for EC2 instance (SSH access)"
  value       = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  description = "Security Group ID for RDS instance (PostgreSQL access from EC2)"
  value       = aws_security_group.rds_sg.id
}

output "alb_sg_id" {
  description = "Security Group ID for Application Load Balancer (HTTP access)"
  value       = aws_security_group.alb_sg.id
}