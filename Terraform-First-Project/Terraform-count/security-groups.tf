# create security groups http and ssh
resource "aws_security_group" "terra-web-sg1" {
  name        = "terra-web-sg1.id-sg"
  description = "allow web and ssh traffic"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    description = "HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_mypublic_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #-1 means all protoclole allows to go out
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    "Name" = "terra-web-sg"
  }
}
