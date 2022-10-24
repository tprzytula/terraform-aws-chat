resource "aws_api_gateway_rest_api" "chat_rest_api" {
    name = "chat-rest-api"
    body = templatefile("${path.module}/policies/chat.yml", var.lambda_functions["connect"])

    endpoint_configuration {
      types = ["REGIONAL"]
    }
}

resource "aws_api_gateway_deployment" "chat_rest_api_deployment" {
    rest_api_id = aws_api_gateway_rest_api.chat_rest_api.id

    triggers = {
      redeployment = sha1(jsonencode(aws_api_gateway_rest_api.chat_rest_api.body))
    }

    lifecycle {
        create_before_destroy = true 
    }
}

resource "aws_api_gateway_stage" "chat_rest_api_stage" {
    rest_api_id = aws_api_gateway_rest_api.chat_rest_api.id
    deployment_id = aws_api_gateway_deployment.chat_rest_api_deployment.id

    stage_name = "v1"
}

resource "aws_lambda_permission" "chat_rest_api_lambda_permissions" {
    statement_id = "AllowExecutionFromAPIGateway-test"
    action = "lambda:InvokeFunction"
    function_name = var.lambda_functions["connect"].function_name
    principal = "apigateway.amazonaws.com"

    source_arn = format("%s/*/*", aws_api_gateway_rest_api.chat_rest_api.execution_arn)
}
