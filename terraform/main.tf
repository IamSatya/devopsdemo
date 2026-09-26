# Main AWS Infrastructure Resources Definition

# 1. Dynamic AMI Lookup for latest Ubuntu 22.04 LTS Server
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 2. Fetch Default VPC & Subnets
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# 3. Dynamic SSH Key Pair Generation with Unique Name Prefix
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name_prefix = "${var.project_name}-key-"
  public_key      = tls_private_key.ssh_key.public_key_openssh
}

# 4. Security Group for Healthcare Web Server with Unique Name Prefix
resource "aws_security_group" "web_sg" {
  name_prefix = "${var.project_name}-sg-"
  description = "Allow HTTP, HTTPS, and SSH inbound traffic for PulseCare Healthcare server"
  vpc_id      = data.aws_vpc.default.id

  # HTTP access
  ingress {
    description      = "HTTP Inbound"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # HTTPS access
  ingress {
    description      = "HTTPS Inbound"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # SSH access
  ingress {
    description = "SSH Access for Deployment"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  # Outbound rule (allow all traffic)
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}-web-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# 5. AWS EC2 Instance for Web Server
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.generated_key.key_name

  user_data = file("${path.module}/scripts/user_data.sh")

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
    tags = {
      Name = "${var.project_name}-root-disk"
    }
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-web-server"
    Role = "WebServer"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# 6. AWS Elastic IP for static IP persistence
resource "aws_eip" "web_eip" {
  instance = aws_instance.web_server.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-eip"
  }
}
