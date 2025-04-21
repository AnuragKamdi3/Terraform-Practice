terraform {
    backend "s3" {
    bucket         = "s3-bucket-for-remote-use"
    region         = "ap-south-1"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt        = true
    }
}