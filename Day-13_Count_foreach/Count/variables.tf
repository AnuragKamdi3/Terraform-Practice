############################### Example-2 Different names #############
variable "env" {
  type    = list(string)
  default = [ "dev", "test", "prod"]
}

resource "aws_instance" "name" {
  ami = "ami-0f1dcc636b69a6438"
  instance_type = "t2.micro"
  count=length(var.env)

  tags = {
      Name = var.env[count.index]
    }
}

# ## example-2 with variables list of string 

variable "ami" {
    type    = string
    default = "ami-0f1dcc636b69a6438"
}

variable "instance_type" {
    type    = string
    default = "t2.micro"
}

variable "sandboxes" {
    type    = list(string)
    default = [ "sandbox_server_two", "sandbox_server_three"]
}