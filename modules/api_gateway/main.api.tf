resource "aws_apigatewayv2_api" "chat_websocket_api" {
  name                       = "chat-websocket-api"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

resource "aws_iam_role" "api_gateway_role" {
  name               = format("api_gateway_role_%s", var.random_name)
  assume_role_policy = data.aws_iam_policy_document.basic_api_gateway_role.json
}

resource "aws_apigatewayv2_stage" "production" {
  api_id = aws_apigatewayv2_api.chat_websocket_api.id
  name   = "production"

  default_route_settings {
    logging_level            = "ERROR"
    throttling_rate_limit    = "500"
    throttling_burst_limit   = "100"
    data_trace_enabled       = false
    detailed_metrics_enabled = false
  }
}

resource "aws_apigatewayv2_route" "connect_route" {
  api_id             = aws_apigatewayv2_api.chat_websocket_api.id
  route_key          = "$connect"
  authorization_type = "NONE"

  target = format("integrations/%s", aws_apigatewayv2_integration.connect_integration.id)
}

resource "aws_apigatewayv2_route" "disconnect_route" {
  api_id             = aws_apigatewayv2_api.chat_websocket_api.id
  route_key          = "$disconnect"
  authorization_type = "NONE"

  target = format("integrations/%s", aws_apigatewayv2_integration.disconnect_integration.id)
}

resource "aws_apigatewayv2_route" "message_route" {
  api_id             = aws_apigatewayv2_api.chat_websocket_api.id
  route_key          = "message"
  authorization_type = "NONE"

  target = format("integrations/%s", aws_apigatewayv2_integration.message_integration.id)
}

resource "aws_apigatewayv2_deployment" "example" {
  depends_on = [
    aws_apigatewayv2_stage.production,
    aws_apigatewayv2_route.connect_route,
    aws_apigatewayv2_route.disconnect_route,
    aws_apigatewayv2_route.message_route
  ]

  api_id = aws_apigatewayv2_api.chat_websocket_api.id

  lifecycle {
    create_before_destroy = true
  }
}