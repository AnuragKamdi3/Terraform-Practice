resource "aws_instance" "TEST1" {
    ami = var.ami
    instance_type = var.instance_type
}
resource "aws_instance" "TEST2" {
    ami = var.ami
    instance_type = var.instance_type
}