output "vpc_id" {
  description = "ID of created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnet"
  value       = [aws_subnet.public-a.id, aws_subnet.public-b.id]
}

output "private_a_id" {
  description = "ID of private subnet in Availability Zone A"
  value       = aws_subnet.private_a.id
}

output "private_b_id" {
  description = "ID of private subnet in Availability Zone B"
  value       = aws_subnet.private_b.id
}