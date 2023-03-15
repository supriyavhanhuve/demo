provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = "vpc-0de2bfe0f5fc540e0"
}

# Create a private subnet
resource "aws_subnet" "my_subnet" {
  vpc_id = "vpc-0de2bfe0f5fc540e0"
  cidr_block = "10.0.1.0/24"
}

  # Create a routing table
resource "aws_route_table" "my_rt" {
  vpc_id = "vpc-0de2bfe0f5fc540e0"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Associate the routing table with the subnet
resource "aws_route_table_association" "my_rta" {
  subnet_id = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_rt.id
}

# Create a security group for the Lambda function
resource "aws_security_group" "my_sg" {
  name_prefix = "my_sg"
  vpc_id = "vpc-0de2bfe0f5fc540e0"
}

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }