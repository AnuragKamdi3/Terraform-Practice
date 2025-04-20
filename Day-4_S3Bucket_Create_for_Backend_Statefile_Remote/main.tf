resource "aws_s3_bucket" "s3-bucket-for-remote-use" {
    bucket = "s3-bucket-for-remote-use"
    tags = {
        Name = "S3_Bucket_for_Remote_Use"
    }
}