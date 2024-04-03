# modules security_group
resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80  # Assuming HTTP traffic
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.lb_security_group_source_cidr]  # Allow from desired source
  }

  egress {
    from_port   = 0  # Allow all outbound traffic
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name = "lb-security-group"
  }
}

resource "aws_security_group" "web_app_security_group" {
  # ... (previous code)

  ingress {
    from_port          = 80
    to_port            = 80
    protocol           = "tcp"
  }

  ingress {
    from_port          = 22
    to_port            = 22
    protocol           = "tcp"
    cidr_blocks        = var.ssh_access_cidr  # Assuming variable is defined
  }

  egress {
    from_port   = 0  # Allow all outbound traffic (update based on needs)
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name = "web-app-security-group"
  }
}

resource "aws_security_group" "database_security_group" {
  vpc_id = var.vpc_id

  ingress {
    from_port          = 3306  # Replace with your database port
    to_port            = 3306
    protocol           = "tcp"
    cidr_blocks        = [aws_security_group.web_app_security_group.id]  # Allow from web app security group
  }

  egress {
    from_port   = 0  # Allow all outbound traffic (update based on needs)
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name = "db-security-group"
  }
}


# resource "aws_security_group" "load_balancer_security_group" {
#   vpc_id = var.vpc_id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = [var.lb_security_group_source_cidr]
#   }

#   egress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = [var.lb_security_group_source_cidr]
#   }

#   tags = {
#     Name = "lb-security-group"
#   }
# }

# resource "aws_security_group" "web_app_security_group" {
#   vpc_id = var.vpc_id

#   ingress {
#     from_port          = 22
#     to_port            = 22
#     protocol           = "tcp"
#     security_group_id = aws_security_group.load_balancer_security_group.id
#   }

#   ingress {
#     from_port          = 80
#     to_port            = 80
#   }
# }