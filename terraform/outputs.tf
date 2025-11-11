output "s3_bucket_name" {
  value       = module.s3.bucket_name
  description = "Name of the S3 bucket used by Lambda"
}

output "lambda_function_name" {
  value       = module.lambda.lambda_name
  description = "Lambda function name"
}

output "lambda_function_arn" {
  value       = module.lambda.lambda_arn
  description = "Lambda function ARN"
}

output "eventbridge_schedule_name" {
  value       = module.eventbridge.schedule_name
  description = "EventBridge schedule name"
}