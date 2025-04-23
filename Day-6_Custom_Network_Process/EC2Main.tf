resource "aws_instance" "E2_Made_Using_TF" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = aws_subnet.TF_SN.id
    key_name = var.key_name
    tags = {
    Name = var.name
    }
}