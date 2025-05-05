data "aws_subnet" "name" {
    filter {
    name   = "tag:Name"
    values = ["Def_SN-1"] # insert value here
    }
}
data "aws_ami" "amzlinux" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
        name = "name"
        values = [ "aws-elasticbeanstalk-amzn-2023.3.20231211.64bit-eb_python39_amazon_linux_2023-hvm-2023-12-16T22-51" ]
    }
    filter {
        name = "root-device-type"
        values = [ "ebs" ]
    }
    filter {
        name = "virtualization-type"
        values = [ "hvm" ]
    }
    filter {
        name = "architecture"
        values = [ "x86_64" ]
    }
}
resource "aws_instance" "name" {
    ami =data.aws_ami.amzlinux.id
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.name.id
}