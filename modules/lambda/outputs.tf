output "lambda_function_connect" {
  value = {
    arn           = aws_lambda_function.connect.arn,
    function_name = aws_lambda_function.connect.function_name
    iam_role_name = aws_iam_role.connect_lambda_role.name
  }
}

output "lambda_function_disconnect" {
  value = {
    arn           = aws_lambda_function.disconnect.arn,
    function_name = aws_lambda_function.disconnect.function_name
    iam_role_name = aws_iam_role.disconnect_lambda_role.name
  }
}

output "lambda_function_message" {
  value = {
    arn           = aws_lambda_function.message.arn,
    function_name = aws_lambda_function.message.function_name
    iam_role_name = aws_iam_role.message_lambda_role.name
  }
}
