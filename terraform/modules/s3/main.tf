variable "environment" {
  type        = string
  description = "Environment name"
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "lambda-${var.environment}-bucket-7483-8939-6719"
  tags = {
    Environment = var.environment
    Name        = "LambdaDemoBucket"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.lambda_bucket.bucket
}