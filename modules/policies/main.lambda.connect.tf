resource "aws_iam_policy" "connect_lambda_logs_policy" {
  name   = format("connect_lambda_logs_policy_%s", var.random_name)
  policy = data.aws_iam_policy_document.basic_logs_policy.json
}

resource "aws_iam_role_policy_attachment" "connect_lambda_basic_role_attachment" {
  role       = var.connect_lambda_role_name
  policy_arn = aws_iam_policy.connect_lambda_logs_policy.arn
}

resource "aws_iam_policy" "connect_lambda_dynamodb_policy" {
  name   = format("connect_lambda_dynamodb_policy_%s", var.random_name)
  policy = data.aws_iam_policy_document.dynamodb_put_policy.json
}

resource "aws_iam_role_policy_attachment" "connect_lambda_role_attachment" {
  role       = var.connect_lambda_role_name
  policy_arn = aws_iam_policy.connect_lambda_dynamodb_policy.arn
}
