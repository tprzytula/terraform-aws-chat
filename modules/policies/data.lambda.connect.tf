data "aws_iam_policy_document" "dynamodb_put_policy" {
  statement {
    sid = "AllowAllActionsOnLogs"
    actions = [
      "dynamodb:PutItem",
    ]
    effect = "Allow"
    resources = [
      var.dynamodb_connections_arn
    ]
  }
}
