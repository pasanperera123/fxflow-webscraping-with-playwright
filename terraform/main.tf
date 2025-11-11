# ✅ Create S3 bucket module
module "s3" {
  source      = "./modules/s3"
  environment = var.environment
}

# ✅ Create Lambda module
module "lambda" {
  source                  = "./modules/lambda"
  environment             = var.environment
  ecr_image_uri           = var.ecr_image_uri
  existing_lambda_role_arn = var.existing_lambda_role_arn
  bucket_name             = module.s3.bucket_name
}

# ✅ Create EventBridge rule module
module "eventbridge" {
  source                        = "./modules/eventbridge"
  environment                   = var.environment
  lambda_arn                    = module.lambda.lambda_arn
  existing_eventbridge_role_arn = var.existing_eventbridge_role_arn
}