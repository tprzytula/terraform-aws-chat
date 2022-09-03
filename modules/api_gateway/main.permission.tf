resource "aws_lambda_permission" "api_gateway_connect" {
  statement_id  = "AllowExecutionFromAPIGateway-connect"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_connect.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  source_arn = format("%s/*/*", aws_apigatewayv2_api.chat_websocket_api.execution_arn)
}

resource "aws_lambda_permission" "api_gateway_disconnect" {
  statement_id  = "AllowExecutionFromAPIGateway-disconnect"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_disconnect.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  source_arn = format("%s/*/*", aws_apigatewayv2_api.chat_websocket_api.execution_arn)
}

resource "aws_lambda_permission" "api_gateway_message" {
  statement_id  = "AllowExecutionFromAPIGateway-disconnect"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_message.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  source_arn = format("%s/*/*", aws_apigatewayv2_api.chat_websocket_api.execution_arn)
}
