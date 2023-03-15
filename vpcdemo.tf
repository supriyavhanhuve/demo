resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
 
 tags = {
   Name = "Project VPC"
 }
}

resource "aws_subnet" "public_subnets" {
 vpc_id            = "vpc-0de2bfe0f5fc540e0"
 cidr_block        = 10.0.1.0/24
 availability_zone = eu-west-1

 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}

resource "aws_subnet" "private_subnets" {
 vpc_id            = "vpc-0de2bfe0f5fc540e0"
 cidr_block        = 10.0.2.0/24
 availability_zone = eu-west-1

 tags = {
   Name = "Private Subnet ${count.index + 1}"
 }
}

   resource "aws_internet_gateway" "gw" {
 vpc_id = 10.0.0.0/16

 tags = {
   Name = "Project VPC IG"
 }

}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

S3 Bucket: "3.devops.candidate.exam"
Region: "eu-west-1"
/usr/bin/bash: line 1: wq: command not found
