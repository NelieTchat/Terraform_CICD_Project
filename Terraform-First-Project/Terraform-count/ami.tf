# create ami
data "aws_ami" "Linux_ami" {
  most_recent = true
  filter { #filter is a dictionary. The filter will go in AWS and fetch the latest ami. AWs 
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  owners = ["amazon"]
}