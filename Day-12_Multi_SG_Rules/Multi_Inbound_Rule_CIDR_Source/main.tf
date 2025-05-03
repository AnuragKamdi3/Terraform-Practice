resource "aws_security_group" "devops_project_anuragg" {
    name        = "devops-project-anuragg"
    description = "Allow restricted inbound traffic"

    ingress {
        description = "SSH access from office network"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["203.0.113.0/24"]  # Replace with your IP
    }

    ingress {
        description = "HTTP access for public users"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # Public access
    }

    ingress {
        description = "HTTPS access for public users"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # Public access
    }

    ingress {
        description = "App access from internal VPC"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]  # Replace with your VPC CIDR
    }

    ingress {
        description = "SonarQube or Jenkins access (Restrict to VPN or internal network)"
        from_port   = 9000
        to_port     = 9000
        protocol    = "tcp"
        cidr_blocks = ["192.168.1.0/24"]  # Replace with your VPN subnet
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Devops_Project_Anuragg"
    }
}