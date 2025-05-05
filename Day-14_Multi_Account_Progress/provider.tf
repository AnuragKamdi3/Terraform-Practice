provider "aws" {
    profile = "dev"
    region = "ap-south-1"
    alias = "account1"
}

provider "aws" {
    profile = "test"
    region = "us-west-1"
    alias = "account2"
}