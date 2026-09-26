# Terraform and Provider Version Definitions

terraform {
  required_version = ">= 1.0.0"

  # Remote S3 Backend for GitHub Actions CI/CD State Persistence
  backend "s3" {
    bucket         = "pulsecare-tfstate-471112662115"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "pulsecare-tflocks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
