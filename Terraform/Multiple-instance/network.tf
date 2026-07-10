resource "aws_vpc" "main" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "two-tier-vpc"
  }
}

### Internet Gateway ###
resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "two-tier-igw"
  }
}

### Public Subnet 1 ###
resource "aws_subnet" "frontend" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet_1_cidr

  availability_zone = "${var.aws_region}a"

  map_public_ip_on_launch = true

  tags = {
    Name = "frontend-subnet"
  }
}

### Public Subnet 2 ###
resource "aws_subnet" "backend" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet_2_cidr

  availability_zone = "${var.aws_region}a"

  map_public_ip_on_launch = true

  tags = {
    Name = "backend-subnet"
  }
}

### Route Table for Public Subnets ###
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

### Associate Public Subnets with Route Table ###
resource "aws_route_table_association" "frontend" {

  subnet_id = aws_subnet.frontend.id

  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "backend" {

  subnet_id = aws_subnet.backend.id

  route_table_id = aws_route_table.public.id
}

