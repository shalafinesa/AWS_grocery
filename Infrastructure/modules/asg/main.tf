/*
# Creates a launch template configuration for EC2 instances in the Auto Scaling Group.
resource "aws_launch_template" "grocery-mate_lt" {
  name_prefix   = "grocery-mate-lt-"
  image_id      = var.ami_id # AMI ID for the EC2 image
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true # Assigns public IPs to the instances
    security_groups             = var.ec2_sg_ids
  }

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  user_data = base64encode(var.user_data) # Optional user-data script (e.g. for installing software)
}

# Defines the Auto Scaling Group for automatic scaling and management of EC2 instances.
resource "aws_autoscaling_group" "app_asg" {
  name                      = "app-asg"
  desired_capacity          = 2  # Number of instances that should run permanently.
  max_size                  = 4  # Maximum number of instances (with high load).
  min_size                  = 1  # Minimum number of instances (for low load).
  vpc_zone_identifier       = var.public_subnets
  launch_template {
    id      = aws_launch_template.grocery-mate_lt.id  # Refers to the launch template.
    version = "$Latest"  # Always uses the latest version of the template.
  }
  target_group_arns = [var.target_group_arn]  # Links the instances to the ALB Target Group.

   # Tags help with identification in the EC2 overview.
  tag {
    key                 = "Name"
    value               = "AppInstance"
    propagate_at_launch = true
  }
}
*/
