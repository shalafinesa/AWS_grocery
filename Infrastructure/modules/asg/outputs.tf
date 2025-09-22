/*
# Returns the name of the Auto Scaling Group.
# So that you can reference it in other modules or use it for error analysis.
output "asg_name" {
  description = "Name der Auto Scaling Group"
  value       = aws_autoscaling_group.app_asg.name
}

# Provides the unique ID of the launch template.
#Important if you want to use the template directly in other resources or modules.
output "launch_template_id" {
  description = "ID des Launch Templates"
  value       = aws_launch_template.grocery-mate_lt.id
}

# Outputs the latest version of the launch template.
# Relevant if you want to make sure that you are working with the latest configuration (e.g. after changes to user_data, AMI, etc.).
output "launch_template_version" {
  description = "Version des Launch Templates"
  value       = aws_launch_template.grocery-mate_lt.latest_version
}
*/
