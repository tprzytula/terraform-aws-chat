data "aws_iam_policy_document" "dynamodb_delete_item_policy" {
  statement {
    sid = "RoleForRemovingConnectionFromDynamoDB"
    actions = [
      "dynamodb:DeleteItem",
    ]
    effect = "Allow"
    resources = [
      var.dynamodb_connections_arn
    ]
  }
}
