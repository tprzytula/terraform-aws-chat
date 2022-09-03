resource "aws_apigatewayv2_integration" "disconnect_integration" {
  api_id = aws_apigatewayv2_api.chat_websocket_api.id

  connection_type    = "INTERNET"
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = var.lambda_function_disconnect.arn
}

resource "aws_apigatewayv2_integration" "connect_integration" {
  api_id = aws_apigatewayv2_api.chat_websocket_api.id

  connection_type    = "INTERNET"
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = var.lambda_function_connect.arn
}

resource "aws_apigatewayv2_integration" "message_integration" {
  api_id = aws_apigatewayv2_api.chat_websocket_api.id

  connection_type    = "INTERNET"
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = var.lambda_function_message.arn
}
