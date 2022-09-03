module "random" {
  source = "./modules/random"
}

module "dynamodb" {
  source = "./modules/dynamodb"

  random_name = module.random.random_name
}

module "lambda" {
  source = "./modules/lambda"

  dynamodb_connections_arn = module.dynamodb.connections_arn
  random_name              = module.random.random_name
}

module "api_gateway" {
  source = "./modules/api_gateway"

  random_name = module.random.random_name

  lambda_function_connect    = module.lambda.lambda_function_connect
  lambda_function_disconnect = module.lambda.lambda_function_disconnect
  lambda_function_message    = module.lambda.lambda_function_message
}

module "policies" {
  source = "./modules/policies"

  random_name = module.random.random_name

  api_gateway_api_id    = module.api_gateway.api_gateway_api_id
  api_gateway_role_name = module.api_gateway.api_gateway_role_name

  dynamodb_connections_arn = module.dynamodb.connections_arn

  connect_lambda_role_name    = module.lambda.lambda_function_connect.iam_role_name
  disconnect_lambda_role_name = module.lambda.lambda_function_disconnect.iam_role_name
  message_lambda_role_name    = module.lambda.lambda_function_message.iam_role_name
}
