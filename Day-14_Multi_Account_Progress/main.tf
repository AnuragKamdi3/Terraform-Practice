resource "aws_s3_bucket" "name" {
    bucket = "mumbai-bucket-anuragg"
    provider = aws.account2
}
resource "aws_s3_bucket" "test" {
    bucket = "us-bucket-anuragg"
    provider = aws.account1
}