
# Configure the VPC
resource "aws_vpc" "Nabeks-vpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Nabeks-vpc1"
  }
}


# Configure the Public Subnet 1
resource "aws_subnet" "Nabeks-Public-Subnet1" {
  vpc_id     = aws_vpc.Nabeks-vpc1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Nabeks-Public-Subnet1"
  }
}

# Configure the Public Subnet 2
resource "aws_subnet" "Nabeks-Public-Subnet2" {
  vpc_id     = aws_vpc.Nabeks-vpc1.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Nabeks-Public-Subnet2"
  }
}

# Configure the Private Subnet 1
resource "aws_subnet" "Nabeks-Private-Subnet1" {
  vpc_id     = aws_vpc.Nabeks-vpc1.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Nabeks-Private-Subnet1"
  }
}

# Configure the Private Subnet 2
resource "aws_subnet" "Nabeks-Private-Subnet2" {
  vpc_id     = aws_vpc.Nabeks-vpc1.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Nabeks-Private-Subnet2"
  }
}


# Configure the Public Route Table
resource "aws_route_table" "Nabeks-Public-RT" {
  vpc_id = aws_vpc.Nabeks-vpc1.id

  tags = {
    Name = "Nabeks-Public-RT"
  }
}

# Configure the Private Route Table
resource "aws_route_table" "Nabeks-Private-RT" {
  vpc_id = aws_vpc.Nabeks-vpc1.id

  tags = {
    Name = "Nabeks-Private-RT"
  }
}


# Route Table Association with Public Subnets
resource "aws_route_table_association" "Nabeks-Public-RT-Association-1" {
  subnet_id      = aws_subnet.Nabeks-Public-Subnet1.id
  route_table_id = aws_route_table.Nabeks-Public-RT.id
}

resource "aws_route_table_association" "Nabeks-Public-RT-Association-2" {
  subnet_id      = aws_subnet.Nabeks-Public-Subnet2.id
  route_table_id = aws_route_table.Nabeks-Public-RT.id
}


# Route Table Association with Private Subnets
resource "aws_route_table_association" "Nabeks-Private-RT-Association-1" {
  subnet_id      = aws_subnet.Nabeks-Private-Subnet1.id
  route_table_id = aws_route_table.Nabeks-Private-RT.id
}


resource "aws_route_table_association" "Naa-Private-RT-Association-2" {
  subnet_id      = aws_subnet.Nabeks-Private-Subnet2.id
  route_table_id = aws_route_table.Nabeks-Private-RT.id
}


# Configure Internet Gateway
resource "aws_internet_gateway" "Nabeks-IGW" {
  vpc_id = aws_vpc.Nabeks-vpc1.id

  tags = {
    Name = "Nabeks-IGW"
  }
}

# Internet Gateway Route
resource "aws_route" "Nabeks-IGW-Route" {
  route_table_id            = aws_route_table.Nabeks-Public-RT.id 
  gateway_id                = aws_internet_gateway.Nabeks-IGW.id 
  destination_cidr_block    = "0.0.0.0/0"
  } 

