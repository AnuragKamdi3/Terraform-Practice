resource "aws_instance" "Test" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"

    tags = {
    Name = "Test"
    }
}