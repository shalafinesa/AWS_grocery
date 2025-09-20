# Specifies the name of the IAM instance profile that is assigned to EC2 instances at startup.
# Is used in the EC2 module or Auto Scaling to transfer the IAM role to instances.
output "ec2_profile_name" { value = aws_iam_instance_profile.ec2_profile.name }
