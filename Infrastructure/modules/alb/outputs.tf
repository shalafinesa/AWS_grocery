# Shows the publicly accessible URL (DNS name) of the application load balancer.
output "alb_dns_name" {
  value = aws_lb.grocery-mate_alb.dns_name
}

# The ARN (Amazon Resource Name) of the Target Group in which your EC2 instances are included.
output "target_group_arn" {
  value = aws_lb_target_group.grocery-mate_tg.arn
}