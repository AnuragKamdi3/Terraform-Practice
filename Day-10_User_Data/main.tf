resource "aws_instance" "name" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    #key_name = "AmazonLinuxKey"
    availability_zone = "ap-south-1a"
    user_data = file("data.sh")
    tags = {
        Name = "User_Data_EX_Server"  
    }
}