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
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.example.id
}

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.nat.id
}

resource "aws_lambda_function" "example" {
  filename         = "example.zip"
  function_name    = "example"
  handler          = "example.handler"
  runtime          = "python3.8"
  memory_size      = 128
  timeout          = 10
  role             = aws_iam_role.lambda.arn
  vpc_config {
    subnet_ids         = [aws_subnet.private.id]
    security_group_ids = [aws_security_group.example.id]
  }
}