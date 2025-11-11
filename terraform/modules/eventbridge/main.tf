variable "existing_eventbridge_role_arn" {
  type        = string
  description = "Existing IAM Role ARN for EventBridge Scheduler"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "lambda_arn" {
  type        = string
  description = "Environment name"
}


resource "aws_scheduler_schedule" "lambda_schedule" {
  name        = "fxflow-lambda-schedule-${var.environment}"
  description = "Triggers Lambda every day at 9 AM Sri Lanka time"

  # Run daily at 9:00 AM SL Time (UTC+5:30 = 3:30 UTC)
  schedule_expression = "cron(30 3 * * ? *)"

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = var.lambda_arn
    role_arn = var.existing_eventbridge_role_arn  # 👈 Existing role used here
  }

  state = "ENABLED"
}

output "schedule_name" {
  value       = aws_scheduler_schedule.lambda_schedule.name
  description = "Name of the EventBridge schedule"
}

output "schedule_arn" {
  value       = aws_scheduler_schedule.lambda_schedule.arn
  description = "ARN of the EventBridge schedule"
}