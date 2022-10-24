module "random" {
  source = "./modules/random"
}

module "dynamodb" {
  source = "./modules/dynamodb"

  random_name = module.random.random_name
}

module "lambda" {
  source = "./modules/lambda"

  random_name              = module.random.random_name
  dynamodb_connections_arn = module.dynamodb.connections_arn
}

module "api_gateway" {
  source = "./modules/api_gateway"

  random_name = module.random.random_name
  lambda_functions = module.lambda.lambda_functions
}
module "api_gateway_v2" {
  source = "./modules/api_gateway_v2"

  random_name      = module.random.random_name
  lambda_functions = module.lambda.lambda_functions
}

module "policies" {
  source = "./modules/policies"

  random_name              = module.random.random_name
  lambda_functions         = module.lambda.lambda_functions
  api_gateway_api_id       = module.api_gateway_v2.api_gateway_api_id
  api_gateway_role_name    = module.api_gateway_v2.api_gateway_role_name
  dynamodb_connections_arn = module.dynamodb.connections_arn
  dynamodb_messages_arn    = module.dynamodb.messages_arn
}
