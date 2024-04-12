#!/bin/bash
yum update -y
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello from Cloudformation on AWS!" > /var/www/html/index.html

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum upgrade
sudo yum install jenkins java-1.8.0-openjdk-devel
sudo systemctl start jenkins
sudo systemctl enable jenkins
