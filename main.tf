# main.tf 

# Generate a random suffix for unique S3 bucket name
resource "random_string" "bucket_suffix" {
  length  = 6
  upper   = false
  special = false
}

# Create an EC2 instance
resource "aws_instance" "first-server-using-terraform" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "MyFirstServer"
  }
}

// VPC
resource "aws_vpc" "my-first-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MyFirstVPC"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.my-first-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "local-subnet"
  }
}

# Create an S3 bucket
resource "aws_s3_bucket" "first-bucket-using-terraform" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# IAM Policy for EC2
resource "aws_iam_policy" "test_policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
        ]
        Effect   = "Allow"
        Resource = [
          aws_s3_bucket.first-bucket-using-terraform.arn,
          "${aws_s3_bucket.first-bucket-using-terraform.arn}/*"
        ]
      },
    ]
  })
}

# IAM Role
resource "aws_iam_role" "ec2_role" {
  name               = "test_ec2_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# Assume Role Policy
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.test_policy.arn
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

# Create an IAM role using JSON formatting

// Json formatting 
# resource "aws_iam_policy" "policy" {
#   name        = "test_policy"
#   path        = "/"
#   description = "My test policy"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:Describe*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }
