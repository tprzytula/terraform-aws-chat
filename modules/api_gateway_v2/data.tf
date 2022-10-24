data "aws_iam_policy_document" "basic_api_gateway_role" {
  statement {
    sid = "RoleForAPIGatewayLogs"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "apigateway.amazonaws.com"
      ]
    }
    effect = "Allow"
  }
}
