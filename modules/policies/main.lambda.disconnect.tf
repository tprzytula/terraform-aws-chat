resource "aws_iam_policy" "disconnect_lambda_dynamodb_policy" {
  name   = format("disconnect_lambda_dynamodb_policy_%s", var.random_name)
  policy = data.aws_iam_policy_document.dynamodb_delete_item_policy.json
}

resource "aws_iam_role_policy_attachment" "disconnect_lambda_role_attachment" {
  role       = var.lambda_functions["disconnect"].iam_role_name
  policy_arn = aws_iam_policy.disconnect_lambda_dynamodb_policy.arn
}
