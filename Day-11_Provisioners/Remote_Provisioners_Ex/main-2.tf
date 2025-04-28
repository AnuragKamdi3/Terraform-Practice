resource "aws_key_pair" "ex" {
    key_name   = "task"  # Replace with your desired key name
    public_key = file("C:/Users/anura/.ssh/id_ed25519.pub") 
}
resource "aws_instance" "server" {
    ami                    = "ami-0f1dcc636b69a6438"
    instance_type          = "t2.micro"
    key_name      = aws_key_pair.ex.key_name

    connection {
        type        = "ssh"
        user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
        # private_key = file("C:/Users/anura/.ssh/id_rsa")
        private_key = file("C:/Users/anura/.ssh/id_ed25519")  #private key path
        host        = self.public_ip
    }
    # local execution process 
    provisioner "local-exec" {
        command = "touch file500" #mysql -h -u user -p
    }
    # File provisioner to copy a file from local to the remote EC2 instance
    provisioner "file" {
        source      = "file10"  # Replace with the path to your local file
        destination = "/home/ubuntu/file10"  # Replace with the path on the remote instance
    }
    # remote execution process 
    provisioner "remote-exec" {
        inline = [
            "touch file200",
            "echo hello from aws >> file200", ##mysql -h -u user -p
        ]
    }
}