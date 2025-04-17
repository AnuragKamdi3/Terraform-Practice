variable "ami_id" {
    description = "Insertion into main code"
    type = string
    default = "ami-002f6e91abff6eb96"
}

variable "instance_type" {
    type = string
    default = "t2.nano"
}