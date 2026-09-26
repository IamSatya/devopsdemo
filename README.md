# 🏥 PulseCare Health - Automated AWS Infrastructure & CI/CD Deployment

[![GitHub Actions CI/CD](https://img.shields.io/badge/GitHub_Actions-AWS_Provision_%26_Deploy-blue?logo=github-actions)](.github/workflows/deploy.yml)
[![Terraform](https://img.shields.io/badge/Terraform-1.6+-purple?logo=terraform)](terraform/)
[![AWS EC2](https://img.shields.io/badge/AWS-EC2%20%2B%20Nginx-orange?logo=amazon-aws)](terraform/main.tf)
[![Automated SSH Key](https://img.shields.io/badge/SSH_Key-Automated_RSA_4096-emerald)]()

A complete DevOps pipeline that automatically **provisions AWS EC2 infrastructure**, **generates an automated RSA 4096-bit SSH key pair**, and **deploys your Healthcare Web Application** on push.

---

## 🔑 Automated Dynamic SSH Key Pair (Zero SSH Setup Required!)

You **do not need to create or paste any SSH key manually**!

1. **Terraform** dynamically generates a 4096-bit RSA SSH Key Pair using `tls_private_key.ssh_key`.
2. Registers the Public Key with AWS EC2 (`aws_key_pair.generated_key`).
3. Passes the Private Key directly into GitHub Actions memory step outputs (`${{ needs.provision-aws-infrastructure.outputs.ssh_key }}`).
4. The Deployment job connects to the EC2 server using the generated key and transfers your website files automatically.

---

## 📁 Repository Structure

```text
aws-devops/
├── .github/
│   └── workflows/
│       └── deploy.yml          # Automated Terraform & SCP Deployment Pipeline
├── website/
│   ├── assets/                 # Healthcare visual assets
│   ├── index.html              # Healthcare service web application
│   ├── styles.css              # Glassmorphism & dark mode styling
│   └── script.js               # Interactive vitals & booking wizard
├── terraform/
│   ├── main.tf                 # EC2, Security Group, Dynamic SSH Key Pair, EIP
│   ├── oidc.tf                 # Keyless OIDC Role for AWS Account 471112662115
│   ├── versions.tf             # AWS & TLS Provider definitions
│   ├── variables.tf            # Input parameters
│   └── outputs.tf              # Public IP, DNS, and Private SSH Key outputs
└── README.md                   # Full documentation & setup guide
```
