output "lambda_name" {
  value = module.lambda.lambda_name
}

output "bucket_name" {
  value = module.s3.bucket_name
}

output "eventbridge_rule" {
  value = module.eventbridge.rule_name
}