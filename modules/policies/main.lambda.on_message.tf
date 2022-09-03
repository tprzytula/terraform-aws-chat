resource "aws_iam_policy" "message_lambda_logs_policy" {
  name   = format("message_lambda_logs_policy_%s", var.random_name)
  policy = data.aws_iam_policy_document.basic_logs_policy.json
}

resource "aws_iam_role_policy_attachment" "message_lambda_basic_role_attachment" {
  role       = var.message_lambda_role_name
  policy_arn = aws_iam_policy.message_lambda_logs_policy.arn
}

resource "aws_iam_policy" "message_lambda_dynamodb_policy" {
  name   = format("message_lambda_dynamodb_policy_%s", var.random_name)
  policy = data.aws_iam_policy_document.dynamodb_scan_policy.json
}

resource "aws_iam_role_policy_attachment" "message_lambda_role_attachment" {
  role       = var.message_lambda_role_name
  policy_arn = aws_iam_policy.message_lambda_dynamodb_policy.arn
}

resource "aws_iam_policy" "message_lambda_manage_connections_policy" {
  name   = format("message_lambda_manage_connections_policy_%s", var.random_name)
  policy = data.aws_iam_policy_document.manage_connections_policy.json
}

resource "aws_iam_role_policy_attachment" "message_lambda_manage_connections_role_attachment" {
  role       = var.message_lambda_role_name
  policy_arn = aws_iam_policy.message_lambda_manage_connections_policy.arn
}