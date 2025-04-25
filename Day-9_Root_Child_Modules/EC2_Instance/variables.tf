variable "instance_name" {
    default = ""
    type = string
}

variable "instance_type" {
    default = "t2.micro"
    type = string
}

variable "ami_id" {
    default = "ami-0f1dcc636b69a6438"
    type = string
}