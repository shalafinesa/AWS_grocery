# Creates an EC2 instance for the Grocery-Mate app
resource "aws_instance" "grocery_ec2" {
  ami                         = "ami-0b74f796d330ab49c" # Amazon Machine Image (AMI) that is used (here: e.g. Ubuntu or Amazon Linux)
  instance_type               = "t2.micro" # Instance type (small, inexpensive instance)
  subnet_id                   = var.subnet_id   # Subnet in which the instance is provided (e.g. public subnet)
  associate_public_ip_address = true    # Ensures that the instance receives a public IP address
  vpc_security_group_ids      = var.vpc_security_group_ids    # Security groups that control access to the instance (e.g. SSH, HTTP)
  key_name                    = var.key_name   # Name of the SSH key pair to connect to the instance via SSH
  iam_instance_profile        = var.iam_instance_profile  # IAM instance profile that gives the EC2 instance certain authorizations

  # Tags for better identification and organization of the instance
  tags = {
    Name = "EC2-Public"
  }
}