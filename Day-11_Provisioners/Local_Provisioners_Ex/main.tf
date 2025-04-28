resource "aws_instance" "example" {
    ami           = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    tags = {
        Name = "null resource"
    }
    provisioner "local-exec" {
        command = "echo Instance public IP is ${self.private_ip} > instance_info.txt"
    }
}