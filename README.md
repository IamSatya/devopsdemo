# 🏥 PulseCare Health - Automated AWS Infrastructure & CI/CD Deployment

[![GitHub Actions CI/CD](https://img.shields.io/badge/GitHub_Actions-AWS_Provision_%26_Deploy-blue?logo=github-actions)](.github/workflows/deploy.yml)
[![Terraform](https://img.shields.io/badge/Terraform-1.6+-purple?logo=terraform)](terraform/)
[![AWS EC2](https://img.shields.io/badge/AWS-EC2%20%2B%20Nginx-orange?logo=amazon-aws)](terraform/main.tf)
[![Keyless OIDC](https://img.shields.io/badge/AWS_Account-471112662115-emerald)]()

A complete DevOps pipeline that automatically **provisions AWS EC2 infrastructure using Terraform** and **deploys your Healthcare Web Application** on push, **without hardcoding any AWS credentials**.

---

## 🔐 Keyless Authentication Setup (AWS Account: 471112662115)

The Terraform configuration in [terraform/oidc.tf](file:///Users/apple/Desktop/aws-devops/terraform/oidc.tf) has been pre-configured specifically for your **AWS Account (`471112662115`)** and **GitHub Repository (`IamSatya/devopsdemo`)**.

### Your IAM Role ARN:
```text
arn:aws:iam::471112662115:role/github-actions-pulsecare-role
```

---

## ⚡ Setup Steps for GitHub Actions

Add the following **3 Secrets** to your GitHub Repository (**Settings > Secrets and variables > Actions**):

| Secret Name | Value to Enter |
| :--- | :--- |
| `AWS_ROLE_TO_ASSUME` | `arn:aws:iam::471112662115:role/github-actions-pulsecare-role` |
| `AWS_REGION` | `us-east-1` (or your preferred region) |
| `EC2_SSH_KEY` | Content of your SSH Private Key file |

---

## 📁 Repository Structure

```text
aws-devops/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions OIDC Provisioning & Deployment Workflow
├── website/
│   ├── assets/                 # Healthcare visual assets
│   ├── index.html              # Healthcare service web application
│   ├── styles.css              # Glassmorphism & dark mode styling
│   └── script.js               # Interactive vitals & booking wizard
├── terraform/
│   ├── main.tf                 # EC2, Security Group, EIP, VPC definitions
│   ├── oidc.tf                 # OIDC Provider & Role for AWS Account 471112662115
│   ├── versions.tf             # AWS Provider & version locking
│   ├── variables.tf            # Input parameters
│   └── outputs.tf              # Public IP & URL outputs
└── README.md                   # Full documentation & setup guide
```
