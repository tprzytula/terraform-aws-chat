resource "aws_iam_policy" "connect_lambda_dynamodb_policy" {
  name   = format("connect_lambda_dynamodb_policy_%s", var.random_name)
  policy = data.aws_iam_policy_document.dynamodb_put_policy.json
}

resource "aws_iam_role_policy_attachment" "connect_lambda_role_attachment" {
  role       = var.lambda_functions["connect"].iam_role_name
  policy_arn = aws_iam_policy.connect_lambda_dynamodb_policy.arn
}
