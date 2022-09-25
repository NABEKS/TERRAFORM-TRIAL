# Configure EC2 Instance

resource "aws_instance" "Test-Server-1" {
  ami           = "ami-0be590cb7a2969726"
  # eu-west-2
  instance_type = "t2.micro"
  key_name = "NABEKS-ANSIBLE-KEYPAIR"
  vpc_security_group_ids = [aws_security_group.Test-Sec-Group.id]
  associate_public_ip_address = true
  subnet_id = aws_subnet.Test-Public-Sub1.id

  tags = {
    Name = "Test-server-1"
    OS = "UBUNTU"
}
}

resource "aws_instance" "Test-Server-2" {
  ami           = "ami-0be590cb7a2969726"
  # eu-west-2
  instance_type = "t2.micro"
  key_name = "NABEKS-ANSIBLE-KEYPAIR"
  vpc_security_group_ids = [aws_security_group.Test-Sec-Group.id]
  associate_public_ip_address = true
  subnet_id = aws_subnet.Test-Public-Sub2.id

  tags = {
    Name = "Test-server-2"
    OS = "UBUNTU"
}
}

