resource "aws_instance" "test" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    tags = {
        Name = "Terraform_Import_Test_EC2"
    }
}