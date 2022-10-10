resource "aws_iam_policy" "remove_lambda_dynamodb_message_update_policy" {
  name   = format("remove_lambda_dynamodb_message_update_policy_%s", var.random_name)
  policy = data.aws_iam_policy_document.dynamodb_remove_messages_policy.json
}

resource "aws_iam_role_policy_attachment" "remove_lambda_role_attachment" {
  role       = var.lambda_functions["remove"].iam_role_name
  policy_arn = aws_iam_policy.remove_lambda_dynamodb_message_update_policy.arn
}

resource "aws_iam_policy" "remove_lambda_manage_connections_policy" {
  name   = format("remove_lambda_manage_connections_policy_%s", var.random_name)
  policy = data.aws_iam_policy_document.manage_connections_policy.json
}

resource "aws_iam_role_policy_attachment" "remove_lambda_manage_connections_role_attachment" {
  role       = var.lambda_functions["remove"].iam_role_name
  policy_arn = aws_iam_policy.remove_lambda_manage_connections_policy.arn
}
