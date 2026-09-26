# 🏥 PulseCare Health - Automated AWS Infrastructure & CI/CD Deployment

[![GitHub Actions CI/CD](https://img.shields.io/badge/GitHub_Actions-AWS_Access_Keys-blue?logo=github-actions)](.github/workflows/deploy.yml)
[![Terraform](https://img.shields.io/badge/Terraform-1.6+-purple?logo=terraform)](terraform/)
[![AWS EC2](https://img.shields.io/badge/AWS-EC2%20%2B%20Nginx-orange?logo=amazon-aws)](terraform/main.tf)
[![Automated SSH Key](https://img.shields.io/badge/SSH_Key-Automated_RSA_4096-emerald)]()

A complete DevOps pipeline that automatically **provisions AWS EC2 infrastructure using Terraform** and **deploys your Healthcare Web Application** on git push using **AWS IAM Access Keys**.

---

## 🔑 GitHub Secrets Configuration

Add these **3 Secrets** to your GitHub Repository (**Settings > Secrets and variables > Actions**):

| Secret Name | Value to Enter |
| :--- | :--- |
| `AWS_ACCESS_KEY_ID` | Your AWS IAM Access Key ID (e.g. `AKIAIOSFODNN7EXAMPLE`) |
| `AWS_SECRET_ACCESS_KEY` | Your AWS IAM Secret Access Key (e.g. `wJalrXUtnFEMI/K...`) |
| `AWS_REGION` | `us-east-1` (or your target region) |

*(Note: SSH Keys and Terraform state are managed 100% automatically by the workflow!)*

---

## ⚡ How the Automated Pipeline Works

1. **Job 1 (Provision AWS Infrastructure)**:
   - Authenticates using `AWS_ACCESS_KEY_ID` & `AWS_SECRET_ACCESS_KEY`.
   - Executes `terraform apply -auto-approve` to provision/update the EC2 server, Security Group, and Elastic IP.
   - Generates a dynamic 4096-bit RSA SSH key pair for deployment.
   - Commits updated Terraform state back to the GitHub repository automatically.

2. **Job 2 (Deploy Website)**:
   - Connects to the EC2 server via SSH using the generated key pair.
   - Synchronizes `website/` files to `/var/www/html/`.
   - Reloads Nginx so updates are live immediately at `http://<EC2_PUBLIC_IP>`.

---

## 📁 Repository Structure

```text
aws-devops/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions Access Keys CI/CD Workflow
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
