# Terraform Input Variable Definitions

variable "aws_region" {
  type        = string
  description = "AWS region for provisioning infrastructure"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment name (production, staging, dev)"
  default     = "production"
}

variable "project_name" {
  type        = string
  description = "Project identifier tag"
  default     = "pulsecare-healthcare"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance size for web server"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "Name of existing AWS EC2 SSH Key Pair (optional)"
  default     = ""
}

variable "allowed_ssh_cidr" {
  type        = list(string)
  description = "Allowed CIDR blocks for SSH access (port 22)"
  default     = ["0.0.0.0/0"]
}
