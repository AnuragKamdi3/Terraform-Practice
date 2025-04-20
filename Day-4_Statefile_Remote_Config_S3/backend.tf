terraform {
    backend "s3" {
        bucket = "s3-bucket-for-remote-use"
        key = "terraform.tfstate"
        region = "ap-south-1"
    }
}