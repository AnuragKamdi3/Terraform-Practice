variable "allowed_ports" {
    type = map(string)
    default = {
        "22"   = "203.0.113.0/24"    # SSH (Restrict to office IP)
        "80"   = "0.0.0.0/0"         # HTTP (Public)
        "443"  = "0.0.0.0/0"         # HTTPS (Public)
        "8080" = "10.0.0.0/16"       # Internal App (Restrict to VPC)
        "9000" = "192.168.1.0/24"    # SonarQube/Jenkins (Restrict to VPN)
    }
}

resource "aws_security_group" "Devops_Project_Anuragg" {
    name        = "Devops_Project_Anuragg"
    description = "Allow restricted inbound traffic"

    dynamic "ingress" {
        for_each = var.allowed_ports
        content {
            description = "Allow access to port ${ingress.key}"
            from_port   = tonumber(ingress.key)
            to_port     = tonumber(ingress.key)
            protocol    = "tcp"
            cidr_blocks = [ingress.value]
        }
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