
# Configure the AWS Provider
provider "aws" {
  region = var.region-name
}

# Configure the VPC
resource "aws_vpc" "Prod-rock-VPC" {
  cidr_block       = var.cidr-for-vpc
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "Prod-rock-VPC"
  }
}


# Configure the Public Subnet 1
resource "aws_subnet" "Test-Public-Sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.cidr-for-public-sub-1
  availability_zone = var.avaialibility-zone-1

  tags = {
    Name = "Test-Public-Sub1"
  }
}

# Configure the Public Subnet 2
resource "aws_subnet" "Test-Public-Sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.cidr-for-public-sub-2
  availability_zone = var.avaialibility-zone-2

  tags = {
    Name = "Test-Public-Sub2"
  }
}

# Configure the Private Subnet 1
resource "aws_subnet" "Test-Priv-Sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.cidr-for-private-sub-1
  availability_zone = var.avaialibility-zone-3

  tags = {
    Name = "Test-Priv-Sub1"
  }
}

# Configure the Private Subnet 2
resource "aws_subnet" "Test-Priv-Sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.cidr-for-private-sub-2
  availability_zone = var.avaialibility-zone-1

  tags = {
    Name = "Test-Priv-Sub2"
  }
}


# Configure the Public Route Table
resource "aws_route_table" "Test-Pub-Route-Table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Test-Pub-Route-Table"
  }
}

# Configure the Private Route Table
resource "aws_route_table" "Test-Priv-Route-Table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Test-Priv-Route-Table"
  }
}


# Route Table Association with Public Subnets
resource "aws_route_table_association" "Test-Pub-Route-Table-Association-1" {
  subnet_id      = aws_subnet.Test-Public-Sub1.id
  route_table_id = aws_route_table.Test-Pub-Route-Table.id
}

resource "aws_route_table_association" "Test-Pub-Route-Table-Association-2" {
  subnet_id      = aws_subnet.Test-Public-Sub2.id
  route_table_id = aws_route_table.Test-Pub-Route-Table.id
}


# Route Table Association with Private Subnets
resource "aws_route_table_association" "Test-Priv-Route-Table-Association-1" {
  subnet_id      = aws_subnet.Test-Priv-Sub1.id
  route_table_id = aws_route_table.Test-Priv-Route-Table.id
}


resource "aws_route_table_association" "Test-Priv-Route-Table-Association-2" {
  subnet_id      = aws_subnet.Test-Priv-Sub2.id
  route_table_id = aws_route_table.Test-Priv-Route-Table.id
}


# Configure Internet Gateway
resource "aws_internet_gateway" "Test-IGW" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Test-IGW"
  }
}

# Internet Gateway Route with Public Route Table
resource "aws_route" "Test-IGW-Route" {
  route_table_id            = aws_route_table.Test-Pub-Route-Table.id 
  gateway_id                = aws_internet_gateway.Test-IGW.id 
  destination_cidr_block    = "0.0.0.0/0"
  } 


# Configure Elastic IP
resource "aws_eip" "Test-EIP-1" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.3"
  depends_on                = [aws_internet_gateway.Test-IGW]
}


# Configure Nat Gateway for Internet through Public Subnet
resource "aws_nat_gateway" "Test-Nat-Gateway" {
  allocation_id = aws_eip.Test-EIP-1.id
  subnet_id     = aws_subnet.Test-Public-Sub1.id
  depends_on = [aws_eip.Test-EIP-1]
}


# Associate the Private Route Table with the Nat Gateway
resource "aws_route" "Test-Nat-Gateway-Ass-Test-Priv-Route-Table" {
  route_table_id            = aws_route_table.Test-Priv-Route-Table.id 
  nat_gateway_id            = aws_nat_gateway.Test-Nat-Gateway.id
  destination_cidr_block    = "0.0.0.0/0"
  } 
