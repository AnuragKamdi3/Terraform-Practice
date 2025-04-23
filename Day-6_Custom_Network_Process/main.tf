resource "aws_vpc" "TF_VPC" {
    cidr_block = "10.0.0.0/16"
    tags = {
    Name = "TF_VPC"
    }
}
resource "aws_internet_gateway" "TF_IG" {
    vpc_id = aws_vpc.TF_VPC.id
}

resource "aws_subnet" "TF_SN" {
    vpc_id = aws_vpc.TF_VPC.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    tags = {
    Name = "TF_SN-1"
    }
}

resource "aws_route_table" "TF_RN" {
    vpc_id = aws_vpc.TF_VPC.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TF_IG.id
    }

    tags = {
    Name = "TF_RouteTable"
    }
}


resource "aws_route_table_association" "TF_RN_A" {
    route_table_id = aws_route_table.TF_RN.id
    subnet_id = aws_subnet.TF_SN.id
}

resource "aws_security_group" "allow_tls" {
    name        = "allow_tls"
    vpc_id      = aws_vpc.TF_VPC.id
    tags = {
    Name = "TF_SG"
    }
ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
    }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
    }
ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
    }
}