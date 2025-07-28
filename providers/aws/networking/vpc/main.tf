# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "MyReusableVPC"
  }
}

# Subnets
resource "aws_subnet" "subnets" {
  count = length(var.subnet_cidr_blocks)

  cidr_block = var.subnet_cidr_blocks[count.index]
  vpc_id     = aws_vpc.main.id

  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}

# Route tables and association
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table_association" "rta" {
  count = length(var.subnet_cidr_blocks)

  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rt.id
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "InternetGateway"
  }
}

# Security Group
resource "aws_security_group" "main" {
  name_prefix = "MyReusableSG-"

  vpc_id = aws_vpc.main.id

  # You can add security rules as you need.
  # For example, open SSH port (22):
  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # ...or allow all traffic in the security group:
  # ingress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   self        = true
  # }

  tags = {
    Name = "MyReusableSG"
  }
}
