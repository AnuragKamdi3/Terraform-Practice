module "this" {
    source          = "./EC2_Instance"
    instance_name   = "Ex-Instance"
    instance_type   = "t2.micro"
    ami_id          = "ami-0f1dcc636b69a6438"
}
