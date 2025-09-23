# 🛒 AWS GroceryMate – Backend & Cloud Setup

**Author:** Finesa Shala  
**GitHub:** [https://github.com/shalafinesa/AWS_grocery](https://github.com/shalafinesa/AWS_grocery)  
**Date:** September 23, 2025

---

## 📋 Table of Contents
1. [Project Overview](#project-overview)  
2. [Architecture Overview](#architecture-overview)  
3. [AWS Infrastructure Components](#aws-infrastructure-components)  
4. [Deployment & Setup](#deployment--setup)  
5. [Environment Variables](#environment-variables)  
6. [Future Enhancements](#future-enhancements)  
7. [License](#license)  

---

## 🔹 Project Overview
AWS GroceryMate is a hands-on project demonstrating a backend application for an online grocery store.  

The project showcases:
- Backend REST API development with Python
- Dockerized services for local deployment
- Integration with AWS services for storage and database
- Basic understanding of cloud deployment and infrastructure

> This version reflects my own work, focused on backend services, storage integration, and Docker deployment.

---

## 🏢 Architecture Overview

![AWS GroceryMate Architecture](./architecture-diagram.png)  
*Include your architecture diagram image in the repository at `architecture-diagram.png`*

Components:
- **VPC**: Default setup for local testing / optional AWS deployment
- **EC2**: Dockerized backend server (manual setup, no auto-scaling)
- **ALB**: Routes traffic to EC2 instance (optional for AWS deployment)
- **RDS**: PostgreSQL database
- **S3 Bucket**: Storage for static assets and user avatars  

> Note: Auto Scaling Groups and Terraform modules were removed because they were not part of my implementation. The architecture reflects the actual local setup.

---

## ⚙️ AWS Infrastructure Components
| Component | Purpose |
|-----------|---------|
| **EC2** | Runs the backend application inside a Docker container |
| **ALB** | Optional load balancer for routing traffic to the instance |
| **RDS** | PostgreSQL database storing products, users, and orders |
| **S3** | Storage for static assets (product images, avatars) |
| **IAM** | Access roles for EC2 and S3 |

---

## 🚀 Deployment & Setup

### Step 1: Clone Repository
```bash
git clone https://github.com/shalafinesa/AWS_grocery.git
cd AWS_grocery/backend
```

### Step 2: Install Dependencies
```bash
pip install -r requirements.txt
```

### Step 3: Run Backend (Docker optional)
## Without Docker:
```bash
python run.py
```

## With Docker:
```bash
docker run --network host \
  -e S3_BUCKET_NAME=your_bucket_name \
  -e POSTGRES_USER=grocery_user \
  -e POSTGRES_PASSWORD=your_db_password \
  -e POSTGRES_DB=grocerymate_db \
  -e POSTGRES_HOST=<RDS_ENDPOINT> \
  -e JWT_SECRET_KEY=your_jwt_secret \
  -p 5000:5000 grocerymate
```

### Step 4: Access Application

- **Backend API endpoints:**  
  - `http://localhost:5000`

- **Example routes:**  
  - `/api/products/` – Get all products  
  - `/api/products/{id}/` – Get product by ID  
  - `/api/auth/login` – User login  
  - `/api/orders/` – Manage orders

### 🔑 Environment Variables

| Variable           | Purpose                                  |
|-------------------|------------------------------------------|
| JWT_SECRET_KEY     | Secret key for JWT authentication       |
| POSTGRES_USER      | Database username                        |
| POSTGRES_PASSWORD  | Database password                        |
| POSTGRES_DB        | Database name                            |
| POSTGRES_HOST      | RDS or local database host               |
| S3_BUCKET_NAME     | Bucket name for static files             |
| S3_REGION          | Bucket region                             |


### 💡 Future Enhancements

- Connect backend to more AWS services (Lambda, EventBridge)  
- Add automated deployment scripts  
- Improve API security and monitoring

### 📜 License

This project is licensed under the **MIT License** and is free for non-commercial use.
