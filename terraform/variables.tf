variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "existing_lambda_role_arn" {
  description = "Existing IAM Role ARN for Lambda"
  type        = string
}

variable "ecr_image_uri" {
  description = "ECR image URI for Lambda"
  type        = string
}