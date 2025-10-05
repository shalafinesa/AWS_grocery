resource "aws_instance" "grocery_ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id # moved to private subnet
  associate_public_ip_address = false                       # no public IP
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_cloudwatch_profile.name

  user_data = templatefile("${path.module}/scripts/user_data.sh", { 
  app_repo_url = var.app_repo_url 
})

  tags = {
    Name = var.instance_name
  }
}


resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow access to EC2 from Bastion and ALB"
  vpc_id      = var.vpc_id

  # SSH from Bastion only
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # HTTP from ALB only
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  # HTTPS from ALB only
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}



