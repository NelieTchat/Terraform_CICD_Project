            #!/bin/bash
            yum update -y
            systemctl enable amazon-ssm-agent
            systemctl start amazon-ssm-agent            
            yum install -y httpd
            systemctl start httpd
            systemctl enable httpd
            echo "Hello from Cloudformation on AWS!" > /var/www/html/index.html