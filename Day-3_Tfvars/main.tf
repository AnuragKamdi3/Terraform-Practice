resource "aws_instance" "DEV1" {
    ami = var.ami
    instance_type = var.instance_type
}
resource "aws_instance" "DEV2" {
    ami = var.ami
    instance_type = var.instance_type
}