# 🛒 AWS GroceryMate Application - Cloud Infrastructure & Deployment

**Author:** Finesa Shala  
**GitHub:** [https://github.com/shalafinesa/AWS_grocery](https://github.com/shalafinesa/AWS_grocery)  
**Date:** September 22, 2025  

This repository contains the **GroceryMate e-commerce application** infrastructure, deployed and managed fully in **AWS** using **Terraform**.  
It emphasizes **cloud infrastructure, deployment, modularity, and automation**, allowing a scalable, secure, and maintainable environment for the application.

---

## 📋 Table of Contents
1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Terraform Infrastructure](#terraform-infrastructure)
4. [AWS Components & Setup](#aws-components--setup)
5. [Deployment & Installation](#deployment--installation)
6. [Environment Variables](#environment-variables)
7. [Future Improvements](#future-improvements)
8. [License](#license)

---

## 📝 Overview
The **AWS GroceryMate App** is a learning project for Masterschool’s Software Engineering Cloud Track.  
It demonstrates:

- Modular **Terraform infrastructure**
- Dockerized backend deployment
- EC2 Auto Scaling & Load Balancing
- RDS for relational database
- Secure S3 integration for static assets
- IAM with least privilege roles
- Bastion host access for private resources

> All resources are deployed in a test setup. Production hardening (private subnets, NAT Gateways, etc.) can be applied easily.

---

🏢 Architecture

![AWS Architecture](docs/architecture.png)

**Key Highlights:**
- VPC: Custom VPC with public/private subnets in 2 AZs
- EC2: Two Dockerized application servers, managed via Auto Scaling Group
- ALB: Distributes incoming traffic to healthy EC2 instances
- RDS: PostgreSQL database in private subnet
- S3: Private bucket for user avatars and static assets
- Bastion Host: Secure SSH access to private EC2 instances
- IAM: Fine-grained access policies for EC2, S3, and other resources

---

## 🔩 Terraform Infrastructure

**Modules:**
| Module           | Purpose |
|-----------------|---------|
| vpc            | Custom VPC with public/private subnets, routing tables, internet gateway |
| app_instance   | EC2 instances with Docker setup for GroceryMate |
| alb            | Application Load Balancer for high availability |
| rds            | PostgreSQL database deployed in private subnets |
| bastion        | Jump host for SSH into private EC2 instances |
| security_groups| Control traffic between EC2, RDS, ALB, and other components |
| s3_bucket      | Private S3 bucket for static content with default avatars |
| iam            | EC2 roles and policies to access S3 and other resources |

> Each module is called from `root/main.tf` with tailored inputs for the account.

---

## 🚀 Deployment & Installation

### Prerequisites
- Python 3.11+
- PostgreSQL (or use RDS)
- Terraform
- AWS CLI with SSO configured

### Steps
1. Clone the repository  
```bash
git clone https://github.com/shalafinesa/AWS_grocery.git
cd AWS_grocery/infrastructure
Configure variables in terraform.tfvars

hcl
Copy code
key_name       = "awsgrocery"
app_repo_url   = "https://github.com/shalafinesa/AWS_grocery.git"
db_name        = "grocerymate_db"
db_user        = "grocery_user"
db_password    = "YourStrongPassword123"
jwt_secret_key = "LD2fo/SGBWcaBguADyKneKBBEQu2ZR29sJI+bODel1U="
my_ip          = "95.223.231.77/32"
Initialize & apply Terraform

bash
Copy code
terraform init
terraform plan
terraform apply
Connect via Bastion (if needed)

bash
Copy code
ssh -i /path/to/your-key.pem ec2-user@<BASTION_PUBLIC_IP>
ssh -A ec2-user@<PRIVATE_EC2_IP>
Set up backend & Docker

bash
Copy code
cd backend
pip install -r requirements.txt

docker run --network host \
  -e S3_BUCKET_NAME=<grocerymate-avatars-finesa123> \
  -e S3_REGION=<eu-north-1> \
  -e USE_S3_STORAGE=true \
  -e POSTGRES_USER=grocery_user \
  -e POSTGRES_PASSWORD=<YourStrongPassword123> \
  -e POSTGRES_DB=grocerymate_db \
  -e POSTGRES_HOST=<grocerymate-db.chk8k46mo6dh.eu-north-1.rds.amazonaws.com> \
  -e POSTGRES_URI=postgresql://grocery_user:YYourStrongPassword123@grocerymate-db.chk8k46mo6dh.eu-north-1.rds.amazonaws.com:5432/grocerymate_db \
  -e JWT_SECRET_KEY=<LD2fo/SGBWcaBguADyKneKBBEQu2ZR29sJI+bODel1U=> \
  -e SECRET_KEY=<LD2fo/SGBWcaBguADyKneKBBEQu2ZR29sJI+bODel1U=> \
  -p http://localhost:5000 grocerymate
Access the application

text
Copy code
http://<ALB_DNS>:5000
🔑 Environment Variables
JWT_SECRET_KEY – secure JWT token for authentication

POSTGRES_* – DB connection info

S3_BUCKET_NAME & S3_REGION – for static asset storage

Replace placeholders with your AWS account info and secure credentials.

💡 Future Improvements
Automate invoices with AWS Lambda + EventBridge

Use Launch Templates for Auto Scaling instead of manual AMI creation

Add CloudWatch metrics & logs for monitoring

Define separate dev/prod environments

📄 License
This project is licensed under the MIT License.
