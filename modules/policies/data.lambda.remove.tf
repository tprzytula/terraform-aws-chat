data "aws_iam_policy_document" "dynamodb_remove_messages_policy" {
  statement {
    sid = "RoleForRemovingConnectionFromDynamoDB"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:Update"
    ]
    effect = "Allow"
    resources = [
      var.dynamodb_messages_arn
    ]
  }
}
