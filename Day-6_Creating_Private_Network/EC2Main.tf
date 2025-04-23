resource "aws_instance" "private_instance" {
    ami                         = var.aws_instance 
    instance_type               = var.aws_instance_type
    subnet_id                   = aws_subnet.private.id
    vpc_security_group_ids      = [aws_security_group.private_sg.id]
    associate_public_ip_address = false
    key_name                    = var.aws_key_name
    tags = {
    Name = var.Name
    }
}