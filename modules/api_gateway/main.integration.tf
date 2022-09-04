resource "aws_apigatewayv2_integration" "lambda_integrations" {
  for_each = var.lambda_functions

  api_id = aws_apigatewayv2_api.chat_websocket_api.id

  connection_type    = "INTERNET"
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = each.value.invoke_arn
}
