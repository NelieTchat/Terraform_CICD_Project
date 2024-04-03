#!/bin/bash
yum update -y        
yum install -y httpd
sudo systemctl start httpd.service
echo " Nelie Launched her Apache Application through Terraform " > /var/www/html/index.html 
sudo systemctl enable httpd.service
sudo systemctl is-enabled httpd

