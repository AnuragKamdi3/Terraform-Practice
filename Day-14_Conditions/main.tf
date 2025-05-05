resource "aws_instance" "dev" {
    ami           = var.ami
    instance_type = var.instance_type
    count         = var.instance_type == "t2.micro" ? 1 : 0
    tags = {
        Name = "dev_server"
    }
}