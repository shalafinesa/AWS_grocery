resource "aws_instance" "grocerymate" {
  ami                    = "ami-00c8ac9147e19828e"  # Ubuntu 22.04 in eu-north-1
  instance_type          = "t2.micro"
  key_name               = "awsgrocery"
  vpc_security_group_ids = ["sg-03db73293905f19a0"]

  tags = {
    Name    = "GroceryMate-Instance"
    Project = "GroceryMate"
  }
}
