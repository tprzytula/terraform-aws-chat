data "aws_iam_policy_document" "dynamodb_remove_messages_policy" {
  statement {
    sid = "RoleForRemovingConnectionFromDynamoDB"
    actions = [
      "dynamodb:UpdateItem",
      "dynamodb:Scan"
    ]
    effect = "Allow"
    resources = [
      var.dynamodb_messages_arn,
      var.dynamodb_connections_arn
    ]
  }
}
