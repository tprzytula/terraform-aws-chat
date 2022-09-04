output "lambda_functions" {
  value = {
    for lambda_name, value in local.lambda_functions :
    lambda_name => {
      arn           = aws_lambda_function.lambda_functions[lambda_name].arn,
      function_name = aws_lambda_function.lambda_functions[lambda_name].function_name
      iam_role_name = aws_iam_role.lambda_roles[lambda_name].name
      route_key     = try(value.route_key, "")
    }
  }
}
