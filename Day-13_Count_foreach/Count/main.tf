resource "aws_instance" "sandbox" {
    ami           = var.ami
    instance_type = var.instance_type
    count         = length(var.sandboxes)
    tags = {
        Name = var.sandboxes[count.index]
    }
}

# #example-3 creating IAM users 
variable "user_names" {
    description = "IAM usernames"
    type        = list(string)
    default     = ["user1", "user2", "user3"]
}

resource "aws_iam_user" "example" {
    count = length(var.user_names)
    name  = var.user_names[count.index]
}