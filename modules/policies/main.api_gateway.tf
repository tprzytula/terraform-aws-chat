resource "aws_iam_policy" "api_gateway_logs_policy" {
  name   = format("api_gateway_logs_policy_%s", var.random_name)
  policy = data.aws_iam_policy_document.api_gateway_logs_policy.json
}

resource "aws_iam_role_policy_attachment" "api_gw_cloudwatch_role_attachment" {
  role       = var.api_gateway_role_name
  policy_arn = aws_iam_policy.api_gateway_logs_policy.arn
}
