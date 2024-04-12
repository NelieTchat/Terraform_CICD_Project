#!/bin/bash
yum update -y  # Update package list only once

# Install and configure SSM agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# Install Apache http server and configure web service
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello from Terraform on AWS!" > /var/www/html/index.html

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum upgrade -y

# Install Jenkins and Java (fix the error)
sudo yum install -y jenkins java-1.8.0-openjdk-devel

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins
