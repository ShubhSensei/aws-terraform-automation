# Output the public IP of the EC2 instance
output "instance_public_ip" {
  value = aws_instance.first-server-using-terraform.public_ip
}

# Output the S3 bucket name
output "bucket_name" {
  value = aws_s3_bucket.first-bucket-using-terraform.bucket
}
