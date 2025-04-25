module "this" {
    source = "../Day-8-modules-source"
    ami_id = "ami-0f1dcc636b69a6438"
    aws_region = "ap-south-1"
    instance_type = "t2.micro"
    key_name = "AmazonLinuxKey"
    instance_name = "Test-1"
    }
