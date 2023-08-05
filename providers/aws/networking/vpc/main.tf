# Recurso VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "MyReusableVPC"
  }
}

# Recurso de subredes
resource "aws_subnet" "subnets" {
  count = length(var.subnet_cidr_blocks)

  cidr_block = var.subnet_cidr_blocks[count.index]
  vpc_id     = aws_vpc.main.id

  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}

# Recurso de tabla de enrutamiento y asociación
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

# Recurso de Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "InternetGateway"
  }
}

# Recurso de Security Group
resource "aws_security_group" "main" {
  name_prefix = "MyReusableSG-"

  vpc_id = aws_vpc.main.id

  # Puedes agregar reglas de seguridad aquí según tus necesidades
  # Por ejemplo, abrir el puerto 22 para SSH:
  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # O permitir todo el tráfico dentro del grupo de seguridad:
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
