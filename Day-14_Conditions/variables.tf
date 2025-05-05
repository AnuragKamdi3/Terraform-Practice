# --------------------------
# Example 1: Conditional S3 Bucket Creation
# --------------------------
variable "create_bucket" {
    description = "Set to true to create the S3 bucket."
    type        = bool
    default     = true
}

resource "aws_s3_bucket" "example" {
    count  = var.create_bucket ? 1 : 0
    bucket = "My-S3-Bucket"
    tags = {
        Name        = "ConditionalBucket"
        Environment = "Dev"
    }
}

# --------------------------
# Example 2: Region Validation
# --------------------------
variable "aws_region" {
    description = "The region in which to create the infrastructure"
    type        = string
    default     = "ap-northeast-1"

    validation {
        condition     = contains(["ap-northeast-1", "ap-northeast-2"], var.aws_region)
        error_message = "The variable 'aws_region' must be one of the following regions: ap-northeast-1, ap-northeast-2"
    }
}

resource "aws_s3_bucket" "dev" {
    count  = contains(["ap-northeast-1", "ap-northeast-2"], var.aws_region) ? 1 : 0
    bucket = "statefile-configuresss"
}

# --------------------------
# Example 4: Conditional EC2 Instance Creation Based on Instance Type
# --------------------------
variable "ami" {
    type    = string
    default = "ami-0abcdef1234567890"
}

variable "instance_type" {
    type    = string
    default = "t2.micro"
}

resource "aws_instance" "example" {
    count         = var.instance_type == "t2.micro" ? 1 : 0
    ami           = var.ami
    instance_type = var.instance_type
    tags = {
    Name = "ConditionalEC2"
    }
}