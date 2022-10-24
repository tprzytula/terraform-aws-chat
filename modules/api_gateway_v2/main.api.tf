resource "aws_apigatewayv2_api" "chat_websocket_api" {
  name                       = "chat-websocket-api"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

resource "aws_iam_role" "api_gateway_role" {
  name               = format("api_gateway_role_%s", var.random_name)
  assume_role_policy = data.aws_iam_policy_document.basic_api_gateway_role.json
}

resource "aws_apigatewayv2_deployment" "api_gateway_deployment" {
  depends_on = [
    aws_apigatewayv2_stage.production,
    aws_apigatewayv2_route.routes
  ]

  api_id = aws_apigatewayv2_api.chat_websocket_api.id

  lifecycle {
    create_before_destroy = true
  }
}