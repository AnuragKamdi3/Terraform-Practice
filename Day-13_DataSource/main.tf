data "aws_subnet" "name" {
    filter {
    name   = "tag:Name"
    values = ["Def_SN-1"] # insert value here
    }
}

resource "aws_instance" "name" {
    ami ="ami-002f6e91abff6eb96"
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.name.id
}