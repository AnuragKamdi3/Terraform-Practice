resource "aws_s3_bucket" "s3-bucket-for-remote-use" {
    bucket = "s3-bucket-for-remote-use"
    tags = {
        Name = "S3_Bucket_for_Remote_Use"
    }
}
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
    name = "terraform-state-lock-dynamo"
    hash_key = "LockID"
    read_capacity = 20
    write_capacity = 20

    attribute {
    name = "LockID"
    type = "S"
    }
}