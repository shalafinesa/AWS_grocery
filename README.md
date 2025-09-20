# AWS Grocery Project

## 📦 Project Overview
AWS Grocery is a cloud-based e-commerce platform designed to demonstrate the deployment of a full-stack application using AWS services.  
The project includes a backend (Python/Flask or Django), a frontend (React/Vue/Angular), and infrastructure deployed on AWS.  

---

## 🏗️ Architecture

### **Backend**
- Python (Flask/Django)
- Handles API endpoints, authentication, and database interactions

### **Frontend**
- React.js / Angular / Vue.js
- Connects to the backend via REST APIs

### **Database**
- AWS RDS (PostgreSQL/MySQL)
- Stores products, users, and orders

### **Infrastructure**
- AWS EC2 → Hosts backend and frontend servers  
- AWS S3 → Stores static assets (images, frontend build)  
- AWS CloudFront → Content Delivery Network for frontend  
- AWS IAM → Secure access management  
- AWS VPC → Isolated network environment  

**Architecture Diagram:**  
     Users
       |
    CloudFront
       |
-----------------
|               |
S3 (Frontend)   EC2 (Backend API)
                   |
                   |
                 RDS (Database)


---

## 💰 AWS Cost Evaluation
- **EC2:** On-demand instance for backend → minimal cost with t2.micro  
- **S3:** Static assets → low cost, pay-per-storage  
- **RDS:** Free tier database used for testing → low cost  
- **CloudFront:** Caching static content → reduces bandwidth cost  
- **IAM & VPC:** No direct cost, only configuration  

> Cost-efficient architecture suitable for a small-scale demonstration project.

---

## ⚡ Features
- User authentication & registration  
- Product listing & search  
- Shopping cart and checkout process  
- Responsive frontend  
- Dockerized backend for easy deployment  

---

## 🛠️ Setup Instructions

### **Backend**
# Navigate to backend folder (if needed)
cd backend

# Create a virtual environment (Mac/Linux)
python3 -m venv venv
source venv/bin/activate

# Windows
# python -m venv venv
# venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run the server
python manage.py runserver

# Navigate to frontend folder
cd frontend

# Install dependencies
npm install

# Run development server
npm start

