provider "aws" {
  region  = "eu-west-1" # Don't change the region
}

/usr/bin/bash: line 1: wq: command not found
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "eu-west-1"
}

module "s3" {
    source = "<path-to-S3-folder>"
    #bucket name should be unique
    bucket_name = "mys3bucket"       
