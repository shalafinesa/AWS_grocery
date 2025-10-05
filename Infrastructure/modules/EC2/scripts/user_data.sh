#!/bin/bash
# Update packages
sudo yum update -y

# Install CloudWatch Agent
sudo yum install -y amazon-cloudwatch-agent

# Start CloudWatch Agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config -m ec2 -c default -s
