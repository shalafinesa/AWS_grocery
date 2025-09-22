# 🛒 AWS GroceryMate – Cloud Infrastructure & Deployment

**Author:** Finesa Shala  
**GitHub:** [https://github.com/shalafinesa/AWS_grocery](https://github.com/shalafinesa/AWS_grocery)  
**Date:** September 23, 2025  

---

## 📋 Table of Contents
1. [Project Overview](#project-overview)  
2. [Architecture Overview](#architecture-overview)  
3. [Terraform Modules](#terraform-modules)  
4. [AWS Infrastructure Components](#aws-infrastructure-components)  
5. [Deployment & Setup](#deployment--setup)  
6. [Environment Variables](#environment-variables)  
7. [Future Enhancements](#future-enhancements)  
8. [License](#license)  

---

## 🔹 Project Overview
The AWS GroceryMate project is a hands-on learning exercise for the **Masterschool Software Engineering Cloud Track**.  
It demonstrates how to deploy a full-stack application using **AWS services** and **Terraform**, focusing on:

- 🔹 Modular infrastructure design  
- ⚡ Scalable and highly available architecture  
- 🐳 Automated deployment of backend services with Docker  
- 🔒 Secure database and storage management  
- 🛠️ Best practices for cloud resource organization and access control  

---

## 🏢 Architecture Overview
- **VPC:** Custom public/private subnets across 2 AZs  
- **EC2:** Dockerized application servers managed with Auto Scaling Groups  
- **ALB:** Routes traffic to healthy EC2 instances  
- **RDS:** PostgreSQL database in private subnet  
- **S3 Bucket:** Private storage for static assets  
- **Bastion Host:** Secure SSH access to private resources  
- **IAM Roles:** Least privilege access policies  

---

## 🔩 Terraform Modules
| Module            | Purpose |
|------------------|---------|
| `vpc`            | Custom VPC with routing, internet gateway, public/private subnets |
| `app_instance`   | EC2 instances configured with Docker for backend services |
| `alb`            | Load balancing for high availability |
| `rds`            | PostgreSQL database deployment in private subnet |
| `bastion`        | Jump host for secure access to private instances |
| `security_groups`| Network traffic rules between EC2, RDS, ALB, and other components |
| `s3_bucket`      | Private S3 bucket for static files and default avatars |
| `iam`            | IAM roles and policies for EC2 and S3 access |

---

## ⚙️ AWS Infrastructure Components
1. **EC2:** Dockerized backend, Auto Scaling  
2. **ALB:** Distributes traffic to healthy instances  
3. **RDS:** Private PostgreSQL database  
4. **S3:** Storage for static assets  
5. **Bastion Host:** Secure SSH to private instances  
6. **IAM:** Least privilege roles  

---

## 🚀 Deployment & Setup

### Prerequisites
- AWS Account with IAM credentials  
- Terraform v1.x  
- Python 3.11+  
- PostgreSQL (or RDS)  
- Docker  

### Step 1: Clone Repository
```bash
git clone https://github.com/shalafinesa/AWS_grocery.git
cd AWS_grocery
Step 2: Configure Terraform
Create terraform.tfvars:

hcl
Copy code
key_name       = "awsgrocery"
app_repo_url   = "https://github.com/shalafinesa/AWS_grocery.git"
db_name        = "grocerymate_db"
db_user        = "grocery_user"
db_password    = "YourStrongPassword123"
jwt_secret_key = "your-generated-jwt-key"
my_ip          = "YOUR_IP/32"
Step 3: Apply Infrastructure
bash
Copy code
cd infrastructure
terraform init
terraform plan
terraform apply
Step 4: Connect via Bastion (optional)
bash
Copy code
ssh -i /path/to/your-key.pem ec2-user@<BASTION_PUBLIC_IP>
ssh -A ec2-user@<PRIVATE_EC2_IP>
Step 5: Setup Backend & Docker
bash
Copy code
cd backend
pip install -r requirements.txt

docker run --network host \
  -e S3_BUCKET_NAME=<your-s3-bucket> \
  -e S3_REGION=<your-region> \
  -e USE_S3_STORAGE=true \
  -e POSTGRES_USER=grocery_user \
  -e POSTGRES_PASSWORD=<YourStrongPassword123> \
  -e POSTGRES_DB=grocerymate_db \
  -e POSTGRES_HOST=<RDS_ENDPOINT> \
  -e POSTGRES_URI=postgresql://grocery_user:<YourStrongPassword123>@<RDS_ENDPOINT>:5432/grocerymate_db \
  -e JWT_SECRET_KEY=<your-jwt-key> \
  -p 5000:5000 grocerymate
Step 6: Access Application
text
Copy code
http://<ALB_DNS>:5000
🔑 Environment Variables
JWT_SECRET_KEY – JWT token for authentication

POSTGRES_* – PostgreSQL database connection info

S3_BUCKET_NAME & S3_REGION – S3 storage for static assets

💡 Future Enhancements
⚡ Event-driven invoice creation with AWS Lambda + EventBridge

🐳 Launch Templates for Auto Scaling instead of manual AMI creation

📊 CloudWatch monitoring & alerts

🔹 Separate dev/prod environments

📄 License
MIT License
