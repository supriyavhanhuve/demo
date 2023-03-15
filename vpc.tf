provider "aws" {
   region = "us-east-2"
/usr/bin/bash: line 1: wq: command not found


Create vpc
 resource "aws_vpc" "Main" {                
   cidr_block       = 10.0.0.0/16
   instance_tenancy = "default"
 }

 Create Internet Gateway and attach it to VPC
 resource "aws_internet_gateway" "IGW" {    
    vpc_id =  10.0.0.0/16               
 }

 Create a Public Subnets.
 resource "aws_subnet" "publicsubnets" {    # Creating Public Subnets
   vpc_id =  10.0.0.0/16
   cidr_block = 10.0.1.0/24       # CIDR block of public subnets
 }

 Create a Private Subnet                   # Creating Private Subnets
 resource "aws_subnet" "privatesubnets" {
   vpc_id =  10.0.0.0/16
   cidr_block = 10.0.2.0/24          # CIDR block of private subnets
 }

 Route table for Public Subnet's
 resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  10.0.0.0/16
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
     }
 }
 Route table for Private Subnet's
