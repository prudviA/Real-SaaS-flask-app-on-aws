resource "aws_vpc" "flask_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "flask_vpc"
  }
}

resource "aws_subnet" "flask_public_subnet" {
  vpc_id                  = aws_vpc.flask_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "flask_public_subnet"
  }
}

resource "aws_internet_gateway" "flask_igw" {
  vpc_id = aws_vpc.flask_vpc.id

  tags = {
    Name = "flask_igw"
  }
}

resource "aws_route_table" "flask_rt" {
  vpc_id = aws_vpc.flask_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.flask_igw.id
  }


  tags = {
    Name = "flask_rt"
  }
}

resource "aws_route_table_association" "public_flask_rt_asso" {
  subnet_id      = aws_subnet.flask_public_subnet.id
  route_table_id = aws_route_table.flask_rt.id
}

resource "aws_eip" "flask_eip" {
  domain = "vpc"
}
# private subnets

resource "aws_nat_gateway" "flask_nat" {
  allocation_id = aws_eip.flask_eip.id
  subnet_id     = aws_subnet.flask_public_subnet.id

  tags = {
    Name = "flask_nat"
  }
}

resource "aws_subnet" "flask_private_subnet_1" {
  vpc_id            = aws_vpc.flask_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "flask_private_subnet"
  }
}


resource "aws_subnet" "flask_private_subnet_2" {
  vpc_id            = aws_vpc.flask_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "flask_private_subnet"
  }
}
resource "aws_route_table" "nat_flask_rt" {
  vpc_id = aws_vpc.flask_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.flask_nat.id
  }


  tags = {
    Name = "nat_flask_rt"
  }
}

resource "aws_route_table_association" "private_flask_rt_asso_1" {
  subnet_id      = aws_subnet.flask_private_subnet_1.id
  route_table_id = aws_route_table.nat_flask_rt.id
}

resource "aws_route_table_association" "private_flask_rt_asso_2" {
  subnet_id      = aws_subnet.flask_private_subnet_2.id
  route_table_id = aws_route_table.nat_flask_rt.id
}
