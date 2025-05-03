provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "name" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    key_name = "AmazonLinuxKey"
    availability_zone = "ap-south-1a"
    count = 2
    tags = {
        Name = "Test-${count.index}"
    }
}