variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "production"
}

variable "existing_lambda_role_arn" {
  description = "Existing IAM Role ARN for Lambda"
  type        = string
}

variable "ecr_image_uri" {
  description = "ECR image URI for Lambda"
  type        = string
}

variable "existing_eventbridge_role_arn" {
  type        = string
  description = "Existing IAM Role ARN for EventBridge Scheduler"
}