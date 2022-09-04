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
