# This file defines variables to make the code reusable and configurable.

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-07b69f62c1d38b012"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-terraform-s3-bucket-2710"
}

variable "access_key" {
  description = "The AWS access key"
  type        = string
}

variable "secret_key" {
  description = "The AWS secret key"
  type        = string
}
