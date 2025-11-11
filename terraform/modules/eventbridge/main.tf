variable "environment" {
  type        = string
  description = "Environment name"
}

variable "lambda_arn" {
  type        = string
  description = "ARN of Lambda function"
}

variable "lambda_name" {
  type        = string
  description = "Name of Lambda function"
}

# EventBridge daily rule (9 AM Sri Lanka time = 3:30 UTC)
resource "aws_cloudwatch_event_rule" "lambda_schedule_rule" {
  name                = "lambda-${var.environment}-daily-trigger"
  description         = "Triggers Lambda every day at 9 AM"
  schedule_expression = "cron(30 3 * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule_rule.name
  target_id = "lambda-${var.environment}-trigger"
  arn       = var.lambda_arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule_rule.arn
}

output "rule_name" {
  value = aws_cloudwatch_event_rule.lambda_schedule_rule.name
}