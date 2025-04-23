variable "ami" {
    description = "passing ami value"
    type = string
    default = "ami-0f1dcc636b69a6438"
}
variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "key_name" {
    type = string
    default = "AmazonLinuxKey"
}
variable "name" {
    description = "The name of the EC2 instance."
    default = "E2_Made_Using_TF"
}