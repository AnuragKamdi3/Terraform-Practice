resource "aws_security_group" "devops_project_anuragg" {
    name        = "Devops-Project-Anuragg"
    description = "Allow TLS inbound traffic"

    dynamic "ingress" {
        for_each = [22, 80, 443, 8080, 9000, 3000, 8082, 8081]
        content {
            description      = "inbound rules"
            from_port        = ingress.value
            to_port          = ingress.value
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            security_groups  = []
            self             = false
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