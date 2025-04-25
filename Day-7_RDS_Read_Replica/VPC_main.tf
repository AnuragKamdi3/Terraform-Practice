# VPC
resource "aws_vpc" "RDS_VPC" {
    cidr_block = "10.0.0.0/16"
    tags = {
    Name= "RDS_TF_VPC"
    }
}
# IG and attch to vpc
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.RDS_VPC.id
}
# Subnets 

resource "aws_subnet" "PUB-1" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.RDS_VPC.id
    availability_zone = "ap-south-1a"
}

resource "aws_subnet" "PUB-2" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.RDS_VPC.id
    availability_zone = "ap-south-1b"
}

# RT, # edit routes 
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.RDS_VPC.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
    }
}

# subnet associations
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.PUB-1.id
    route_table_id = aws_route_table.name.id
}
resource "aws_route_table_association" "name2" {
    subnet_id = aws_subnet.PUB-2.id
    route_table_id = aws_route_table.name.id
}