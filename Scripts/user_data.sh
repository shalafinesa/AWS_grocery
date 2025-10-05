#!/bin/bash
# Update system packages
yum update -y

# Install Docker
amazon-linux-extras install docker -y
service docker start
systemctl enable docker

# Add ec2-user to docker group
usermod -a -G docker ec2-user

# Switch to ec2-user home
cd /home/ec2-user

# Install git
yum install git -y

# Clone your app repo 
git clone ${app_repo_url} app

cd app

# Build Docker image (replace "your-app" with the image name you want)
docker build -t your-app .

# Run container (replace ports if needed)
docker run -d -p 80:80 your-app
