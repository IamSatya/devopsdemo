# 🏥 PulseCare Health - Automated AWS Infrastructure & CI/CD Deployment

[![GitHub Actions CI/CD](https://img.shields.io/badge/GitHub_Actions-AWS_Provision_%26_Deploy-blue?logo=github-actions)](.github/workflows/deploy.yml)
[![Terraform](https://img.shields.io/badge/Terraform-1.6+-purple?logo=terraform)](terraform/)
[![AWS EC2](https://img.shields.io/badge/AWS-EC2%20%2B%20Nginx-orange?logo=amazon-aws)](terraform/main.tf)
[![GitHub State Backend](https://img.shields.io/badge/Terraform_State-GitHub_Backed-emerald)]()

A complete DevOps pipeline that automatically **provisions AWS EC2 infrastructure using Terraform** and **deploys your Healthcare Web Application** on push, with **Terraform state managed directly inside your GitHub Repository**.

---

## 📦 How GitHub-Backed Terraform State Works (Option 1)

No AWS S3 bucket or DynamoDB table needed!

1. When a workflow runs, GitHub Actions checks out your repository.
2. Terraform executes `terraform apply` using the repository state.
3. The step `Commit Updated Terraform State Back to GitHub` automatically commits any state updates back to your repo using `[skip ci]` to prevent infinite workflow loops.

---

## 🔐 Setup Steps for GitHub Actions

Add the following **3 Secrets** in GitHub Repository (**Settings > Secrets and variables > Actions**):

| Secret Name | Value |
| :--- | :--- |
| `AWS_ROLE_TO_ASSUME` | `arn:aws:iam::471112662115:role/github-actions-pulsecare-role` |
| `AWS_REGION` | `us-east-1` (or your preferred region) |
| `EC2_SSH_KEY` | Contents of your SSH Private Key file |

---

## 📁 Repository Structure

```text
aws-devops/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions OIDC & Git-Backed State Pipeline
├── website/
│   ├── assets/                 # Healthcare visual assets
│   ├── index.html              # Healthcare service web application
│   ├── styles.css              # Glassmorphism & dark mode styling
│   └── script.js               # Interactive vitals & booking wizard
├── terraform/
│   ├── main.tf                 # EC2, Security Group, EIP, VPC definitions
│   ├── oidc.tf                 # Keyless OIDC Role for AWS Account 471112662115
│   ├── versions.tf             # AWS Provider definitions
│   ├── variables.tf            # Input parameters
│   └── outputs.tf              # Public IP & URL outputs
└── README.md                   # Full documentation & setup guide
```
