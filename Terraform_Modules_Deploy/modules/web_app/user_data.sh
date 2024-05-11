#!/bin/bash
# *install apache2 with ubuntu*
apt-get update -y
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "Terraform modules launched successfully" > /var/www/html/index.html

# yum update -y
# yum install httpd -y
# echo "Terraform modules launched successfully" > /var/www/html/index.html
# systemctl start httpd
# systemctl enable httpd   
