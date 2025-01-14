terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

# Provider block to specify AWS as the cloud provider
provider "aws" {
  region = var.aws_region
}