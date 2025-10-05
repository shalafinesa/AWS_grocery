output "alb_dns_name" {
  value       = aws_lb.app_alb.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "Security Group ID of the ALB"
}

output "alb_target_group_arn" {
  value       = aws_lb_target_group.app_tg.arn
  description = "Target group ARN for private EC2s"
}
