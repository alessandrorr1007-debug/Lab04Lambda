module "vpc" {
  source = "./modules/vpc"
  env    = var.env
}

module "s3" {
  source      = "./modules/s3"
  env         = var.env
  bucket_name = var.bucket_name
}

module "sqs" {
  source = "./modules/sqs"
  env    = var.env
}

module "lambda" {
  source   = "./modules/lambda"
  env      = var.env
  s3_bucket = module.s3.bucket_name
  sqs_arn   = module.sqs.queue_arn
}

module "apigateway" {
  source = "./modules/apigateway"
  env    = var.env
  lambda_upload_arn = module.lambda.upload_arn
  lambda_upload_invoke_arn = module.lambda.upload_invoke_arn
}