provider "aws" {
  region  = "eu-north-1"
  profile = "my-sso-profile"
}

# ------------------
# VPC
# ------------------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "grocery_vpc"
  }
}

# ------------------
# Public Subnets
# ------------------
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(["10.0.1.0/24","10.0.2.0/24"], count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(["eu-north-1a", "eu-north-1b"], count.index)

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

# ------------------
# Private Subnets
# ------------------
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(["10.0.3.0/24","10.0.4.0/24"], count.index)
  availability_zone = element(["eu-north-1a", "eu-north-1b"], count.index)

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

# ------------------
# Internet Gateway
# ------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "grocery_igw"
  }
}

# ------------------
# Route Tables
# ------------------

# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private route table (no NAT, just isolated private subnets)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
