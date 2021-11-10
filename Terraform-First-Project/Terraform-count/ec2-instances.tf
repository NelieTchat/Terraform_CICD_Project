# create public instance
resource "aws_instance" "linux_instance" {
  ami                         = data.aws_ami.Linux_ami.id
  instance_type               = var.instance_type
  key_name                    = var.instance_key_pair
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.terra-pub-sub1.id
  vpc_security_group_ids      = [aws_security_group.terra-web-sg1.id]
  tags = {
    Name = "tf-pub-ec2"

  }
}
# create private instance
resource "aws_instance" "linux_instance1" {
  ami = data.aws_ami.Linux_ami.id
  #instance_type         = var.instance_type # since we want it dynamic,
  #instance_type         = var.instance_type_list[4]
  instance_type          = var.instance_type
  key_name               = var.instance_key_pair
  subnet_id              = aws_subnet.terra-pub-sub1.id
  vpc_security_group_ids = [aws_security_group.terra-web-sg1.id]
  tags = {
    Name = "tf-pub-ec2"
  }
}