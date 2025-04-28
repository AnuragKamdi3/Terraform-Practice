# Create Key Pair
resource "aws_key_pair" "example" {
    key_name   = "task"
    public_key = file(pathexpand("C:/Users/anura/.ssh/id_ed25519.pub"))
}

# IAM Policy for S3 access
resource "aws_iam_policy" "s3_access_policy" {
    name        = "EC2S3AccessPolicy"
    description = "Policy for EC2 instances to access S3"
    policy      = jsonencode({
        Version   = "2012-10-17"
        Statement = [{
            Action   = [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ]
        Effect   = "Allow"
        Resource = [
            "arn:aws:s3:::multicloudnareshitveeraa",
            "arn:aws:s3:::multicloudnareshitveeraa/*"
        ]
        }]
    })
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
    name = "ec2_s3_access_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action    = "sts:AssumeRole"
            Effect    = "Allow"
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        }]
    })
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "ec2_role_attachment" {
    role       = aws_iam_role.ec2_role.name
    policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Instance profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
    name = "ec2_s3_access_instance_profile"
    role = aws_iam_role.ec2_role.name
}

# EC2 instance
resource "aws_instance" "web_server" {
    ami                    = "ami-0f1dcc636b69a6438" # update AMI as necessary
    instance_type          = "t2.micro"
    key_name               = aws_key_pair.example.key_name
    vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
    iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name

    tags = {
        Name = "MyWebServer"
    }
}

# Security group to allow SSH and HTTP
resource "aws_security_group" "allow_ssh_http" {
    name        = "allow_ssh_http"
    description = "Allow SSH and HTTP inbound traffic"

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Null resource to setup instance
resource "null_resource" "setup_and_upload" {
    depends_on = [aws_instance.web_server]

    connection {
        type        = "ssh"
        host        = aws_instance.web_server.public_ip
        user        = "ec2-user"
        private_key = file(pathexpand("C:/Users/anura/.ssh/id_ed25519"))
        timeout     = "2m"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo yum update -y",
            "sudo yum install -y httpd awscli",  # Install awscli too
            "sudo systemctl start httpd",
            "sudo systemctl enable httpd",
            "echo '<h1>Welcome to My Web Server</h1>' | sudo tee /var/www/html/index.html",
            "aws s3 cp /var/www/html/index.html s3://multicloudnareshitveeraa/"
        ]
    }

    triggers = {
        instance_id = aws_instance.web_server.id
    }
}