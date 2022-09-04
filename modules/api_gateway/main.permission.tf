resource "aws_lambda_permission" "api_gateway_lambda_permissions" {
  for_each = var.lambda_functions

  statement_id  = "AllowExecutionFromAPIGateway-connect"
  action        = "lambda:InvokeFunction"
  function_name = each.value.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  source_arn = format("%s/*/*", aws_apigatewayv2_api.chat_websocket_api.execution_arn)
}
