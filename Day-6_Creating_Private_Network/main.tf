resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
    Name = "TF_PVT_VPC"
    }
}

# Internet Gateway (needed for public subnet/NAT)
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
    Name = "TF_PUB_TG"
    }
}

# Public Subnet (for NAT)
resource "aws_subnet" "public" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "ap-south-1a"

    tags = {
    Name = "TF_Public_SN"
    }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
    domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "natgw" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public.id

    tags = {
    Name = "MainNATGateway"
    }
}

# Private Subnet
resource "aws_subnet" "private" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-south-1a"
    tags = {
    Name = "TF_PVT_SN"
    }
}

# Private Route Table
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id

    route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
    }

    tags = {
    Name = "TF_PVT_RT"
    }
}

# Route Table Association
resource "aws_route_table_association" "private_assoc" {
    subnet_id      = aws_subnet.private.id
    route_table_id = aws_route_table.private_rt.id
}

# Security Group for Private Instance (Allow outbound only)
resource "aws_security_group" "private_sg" {
    name        = "private_sg"
    description = "Allow outbound traffic"
    vpc_id      = aws_vpc.main.id

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
    Name = "TF_PVT_EC2_SG"
    }
}
