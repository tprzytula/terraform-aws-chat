output "api_gateway_api_id" {
  value = aws_apigatewayv2_api.chat_websocket_api.id
}

output "api_gateway_role_name" {
  value = aws_iam_role.api_gateway_role.name
}