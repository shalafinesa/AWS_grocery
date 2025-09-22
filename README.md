🛒 AWS GroceryMate – Cloud Infrastructure & Deployment

Author: Finesa Shala
GitHub: https://github.com/shalafinesa/AWS_grocery

Date: September 23, 2025

📋 Table of Contents

Project Overview

Architecture Overview

Terraform Modules

AWS Infrastructure Components

Deployment & Setup

Environment Variables

Future Enhancements

License

🔹 Project Overview

The AWS GroceryMate project is a hands-on learning exercise for the Masterschool Software Engineering Cloud Track.
It demonstrates how to deploy a full-stack application using AWS services and Terraform, focusing on:

Modular infrastructure design

Scalable and highly available architecture

Automated deployment of backend services with Docker

Secure database and storage management

Best practices for cloud resource organization and access control

This repository contains everything needed to deploy a test instance of GroceryMate, including backend, frontend, and infrastructure-as-code setup.

🏢 Architecture Overview

The architecture is designed to be scalable, secure, and easy to maintain, using standard AWS services:

VPC: Custom public and private subnets across multiple availability zones

EC2: Dockerized application servers managed with Auto Scaling Groups

Application Load Balancer (ALB): Routes traffic to healthy EC2 instances

RDS (PostgreSQL): Private database server for secure data storage

S3 Bucket: Private storage for static assets and user files

Bastion Host: Secure SSH access to private resources

IAM Roles: Least privilege access policies for services and resources

The infrastructure can be deployed in a test environment first and easily adapted for production with private subnets, NAT Gateways, and monitoring tools.

🔩 Terraform Modules

Each module encapsulates a key component of the infrastructure:

Module	Purpose
vpc	Custom VPC with routing, internet gateway, public/private subnets
app_instance	EC2 instances configured with Docker for backend services
alb	Load balancing for high availability
rds	PostgreSQL database deployment in private subnet
bastion	Jump host for secure access to private instances
security_groups	Network traffic rules between EC2, RDS, ALB, and other components
s3_bucket	Private S3 bucket for static files and default avatars
iam	IAM roles and policies for EC2 and S3 access

All modules are invoked from main.tf with project-specific variables.

⚙️ AWS Infrastructure Components

The infrastructure is composed of the following AWS services:

EC2: Hosts the backend and Dockerized app; integrated with Auto Scaling for resilience

ALB: Routes traffic to multiple EC2 instances, ensuring high availability

RDS: Private PostgreSQL instance for storing app data

S3: Secure storage for static assets

Bastion Host: Enables SSH access to private instances without exposing them publicly

IAM: Role-based access control, ensuring resources can only perform necessary actions

🚀 Deployment & Setup
Prerequisites

AWS Account with IAM credentials

Terraform v1.x

Python 3.11+

PostgreSQL (optional if using RDS)

Docker (for local backend deployment)

Step 1: Clone Repository
git clone https://github.com/shalafinesa/AWS_grocery.git
cd AWS_grocery

Step 2: Configure Terraform

Create a terraform.tfvars file and populate with your variables:

key_name       = "awsgrocery"
app_repo_url   = "https://github.com/shalafinesa/AWS_grocery.git"
db_name        = "grocerymate_db"
db_user        = "grocery_user"
db_password    = "YourStrongPassword123"
jwt_secret_key = "your-generated-jwt-key"
my_ip          = "YOUR_IP/32"

Step 3: Initialize & Apply Terraform
cd infrastructure
terraform init
terraform plan
terraform apply


Terraform downloads required providers locally; .terraform/ is ignored in Git.

Step 4: Connect via Bastion (if needed)
ssh -i /path/to/your-key.pem ec2-user@<BASTION_PUBLIC_IP>
ssh -A ec2-user@<PRIVATE_EC2_IP>

Step 5: Setup Backend & Docker
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

Step 6: Access the Application
http://<ALB_DNS>:5000

🔑 Environment Variables

JWT_SECRET_KEY – secure JWT for authentication

POSTGRES_* – database connection info

S3_BUCKET_NAME & S3_REGION – static asset storage

Replace all placeholders with your secure credentials and AWS info.

💡 Future Enhancements

Event-driven invoice creation with AWS Lambda + EventBridge

Use Launch Templates for Auto Scaling instead of manual AMI creation

Add CloudWatch monitoring and alerts

Separate dev/prod environments with modular Terraform

📄 License

This project is licensed under MIT License