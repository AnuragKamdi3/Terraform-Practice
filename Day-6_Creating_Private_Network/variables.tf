variable "aws_instance" {
    default = "ami-0f1dcc636b69a6438"
    type = string
}
variable "aws_instance_type" {
    default = "t2.micro"
    type = string
}
variable "aws_key_name" {
    default = "AmazonLinuxKey"
    type = string
}
variable "Name" {
    default = "TF_PVT_EC2"
    type = string
}