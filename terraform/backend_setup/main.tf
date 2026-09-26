# Terraform State Backend Infrastructure (S3 + DynamoDB)
# Run this once to provision your remote state storage in AWS Account 471112662115

provider "aws" {
  region = "us-east-1"
}

# 1. S3 Bucket for Terraform State Storage
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "pulsecare-tfstate-471112662115"
  force_destroy = true

  tags = {
    Name        = "PulseCare Terraform Remote State Storage"
    Environment = "production"
  }
}

# Enable Versioning for State Recovery
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block Public Access to S3 State Bucket
resource "aws_s3_bucket_public_access_block" "terraform_state_public_block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 2. DynamoDB Table for Concurrent State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "pulsecare-tflocks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "PulseCare Terraform State Lock Table"
    Environment = "production"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}
