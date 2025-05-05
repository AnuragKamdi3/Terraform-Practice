resource "aws_s3_bucket" "anuragg_bucket" {
    bucket = "my-app-${terraform.workspace}-bucket"
    tags = {
        Environment = terraform.workspace
        Owner       = "Anuragg"
    }
}