# Configure security group
resource "aws_security_group" "Test-Sec-Group" {
  name        = "Test-Sec-Group"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.Prod-rock-VPC.id

# Configure Ingress HTTP
  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

# Configure Ingress SSH
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Configure Egress
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_HTTP"
  }
}
