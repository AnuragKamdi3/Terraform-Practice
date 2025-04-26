# S3 Bucket to Store Lambda Code
resource "aws_s3_bucket" "lambda_bucket" {
    bucket         = "lambda-code-upload-with-s3"
    force_destroy  = true
    tags = {
        Name = "LambdaBucketUploadwithS3"
    }
}

# Upload Lambda Code to S3
resource "aws_s3_object" "lambda_code" {
    bucket = aws_s3_bucket.lambda_bucket.id
    key    = "Lambda_Function.zip"
    source = "Lambda_Function.zip" # Local path to your zip file
    etag   = filemd5("Lambda_Function.zip")
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
    name = "my_lambda_exec_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
            Effect = "Allow",
            Principal = {
                Service = "lambda.amazonaws.com"
            },
        Action = "sts:AssumeRole"
    }]
    })
}

# Attach Basic Execution Role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
    role       = aws_iam_role.lambda_exec_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Function
resource "aws_lambda_function" "my_lambda" {
    function_name = "my_lambda_function"
    role          = aws_iam_role.lambda_exec_role.arn
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.12"
    timeout       = 900
    memory_size   = 128
    s3_bucket     = aws_s3_bucket.lambda_bucket.id
    s3_key        = aws_s3_object.lambda_code.key
    source_code_hash = filebase64sha256("Lambda_Function.zip") # Still needed for S3 deployments

    environment {
        variables = {
            ENV_VAR_KEY = "ENV_VAR_VALUE"
        }
    }
    tags = {
    Name = "MyLambdaFunction"
    }
}