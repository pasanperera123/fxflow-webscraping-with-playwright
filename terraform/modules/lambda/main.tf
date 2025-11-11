variable "environment" {
  type        = string
  description = "Environment name"
}

variable "existing_lambda_role_arn" {
  type        = string
  description = "Existing IAM Role ARN for Lambda"
}

variable "ecr_image_uri" {
  type        = string
  description = "ECR image URI for Lambda"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name for Lambda environment variable"
}

resource "aws_lambda_function" "lambda" {
  function_name = "fxflow-lambda-${var.environment}"
  package_type  = "Image"
  role          = var.existing_lambda_role_arn
  image_uri     = var.ecr_image_uri
  timeout       = 180
  memory_size   = 2048

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }

  tags = {
    Environment = var.environment
    Name        = "fxflow-lambda-${var.environment}"
  }
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}

output "lambda_name" {
  value = aws_lambda_function.lambda.function_name
}
