resource "null_resource" "create_file" {
    provisioner "local-exec" {
        command = "echo 'Terraform created this file.' > hello_from_terraform.txt"
    }
    triggers = {
        always_run = "${timestamp()}"
    }
}