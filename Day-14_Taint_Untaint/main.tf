resource "aws_key_pair" "name" {
    key_name = "public"
    public_key = file("C:/Users/anura/.ssh/id_ed25519.pub")
}

resource "aws_instance" "example" {
    ami           = "ami-03bb6d83c60fc5f7c"
    instance_type = "t2.micro"
    tags = {
        Name = "TaintReplaceDemo"
    }
}