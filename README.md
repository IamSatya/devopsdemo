# 🏥 PulseCare Health - Automated AWS Infrastructure & CI/CD Deployment

[![GitHub Actions CI/CD](https://img.shields.io/badge/GitHub_Actions-AWS_Access_Keys-blue?logo=github-actions)](.github/workflows/deploy.yml)
[![Terraform](https://img.shields.io/badge/Terraform-1.6+-purple?logo=terraform)](terraform/)
[![AWS EC2](https://img.shields.io/badge/AWS-EC2%20%2B%20Nginx-orange?logo=amazon-aws)](terraform/main.tf)
[![Teardown Support](https://img.shields.io/badge/Teardown-Manual_Destroy_Supported-red)](.github/workflows/destroy.yml)

A complete DevOps pipeline that automatically **provisions AWS EC2 infrastructure using Terraform** and **deploys your Healthcare Web Application** on git push.

---

## 🧹 How to Destroy AWS Resources (Teardown)

When you are finished testing and want to delete all AWS resources (EC2 instance, Security Group, Elastic IP) to prevent any charges:

### Option 1: Via GitHub Actions Web Interface (Easiest)
1. Go to your GitHub Repository > **Actions** tab.
2. Select **Manual Destroy AWS Infrastructure** workflow from the left sidebar.
3. Click **Run workflow** > **Run workflow**.
4. GitHub Actions will run `terraform destroy -auto-approve` and delete all AWS resources automatically!

### Option 2: Via Local Terminal
From your computer terminal inside the project directory:
```bash
cd terraform
terraform destroy -auto-approve
```

---

## 🔑 Required GitHub Secrets

Add these **3 Secrets** in GitHub Repository (**Settings > Secrets and variables > Actions**):

| Secret Name | Value to Enter |
| :--- | :--- |
| `AWS_ACCESS_KEY_ID` | Your AWS Access Key ID |
| `AWS_SECRET_ACCESS_KEY` | Your AWS Secret Access Key |
| `AWS_REGION` | `us-east-1` (or your preferred region) |

---

## 📁 Repository Structure

```text
aws-devops/
├── .github/
│   └── workflows/
│       ├── deploy.yml          # Automated Terraform Provision & Deployment Workflow
│       └── destroy.yml         # Manual AWS Resource Teardown Workflow
├── website/
│   ├── assets/                 # Healthcare visual assets
│   ├── index.html              # Healthcare service web application
│   ├── styles.css              # Glassmorphism & dark mode styling
│   └── script.js               # Interactive vitals & booking wizard
├── terraform/
│   ├── main.tf                 # EC2, Security Group, Dynamic SSH Key Pair, EIP
│   ├── versions.tf             # AWS & TLS Provider definitions
│   ├── variables.tf            # Input parameters
│   └── outputs.tf              # Public IP, DNS, and Private SSH Key outputs
└── README.md                   # Full documentation & setup guide
```
