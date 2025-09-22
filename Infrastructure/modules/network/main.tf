# Creates a Virtual Private Cloud (VPC) network with the CIDR block 10.0.0.0/16.
# This is the superordinate network in which all subnets, gateways etc. are located.
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "main-vpc" }
}

# Creates an Internet gateway to enable public traffic.
# Is linked to the VPC to enable instances in public subnets to access the Internet.
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "main-igw" }
}

# Creates a public subnet in availability zone eu-central-1a. AZs may vary, depending on your location.
# With `map_public_ip_on_launch = true` EC2 instances in this subnet automatically receive public IPs.
resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = var.az_public_a
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-a" }
}

# Creates a public subnet in availability zone eu-central-1b. AZs may vary, depending on your location.
# With `map_public_ip_on_launch = true` EC2 instances in this subnet automatically receive public IPs.
# Specify 2 public subnets in different AZs is necessary to be able to create an ALB.
resource "aws_subnet" "public-b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = var.az_public_b
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-b" }
}

# Creates a private subnet in AZ eu-central-1a.
# Typically used for databases (no Internet access).
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = var.az_private_a
  tags = { Name = "private-a" }
}

# Creates another private subnet in another AZ (eu-central-1b).
# Enables reliability and high availability.
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.az_private_b
  tags = { Name = "private-b" }
}