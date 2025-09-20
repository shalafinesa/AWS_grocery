# IAM Instance Profile, which assigns the role of the EC2 instance (used at EC2 start)
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_connect_role.name
}

# IAM Role for EC2 instances to connect to EC2 Instance Connect (SSH via console)
resource "aws_iam_role" "ec2_connect_role" {
  name = "ec2-instance-connect-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM policy for the EC2 Connect role, allows sending the SSH public key (EC2 Instance Connect)
resource "aws_iam_role_policy" "ec2_connect_policy" {
  name = "ec2-instance-connect-policy"
  role = aws_iam_role.ec2_connect_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = "ec2-instance-connect:SendSSHPublicKey",
      Resource = "*"
    }]
  })
}


