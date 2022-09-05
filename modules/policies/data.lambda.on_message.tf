data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "dynamodb_on_message_connections_policy" {
  statement {
    sid = "RoleForRemovingConnectionFromDynamoDB"
    actions = [
      "dynamodb:Scan"
    ]
    effect = "Allow"
    resources = [
      var.dynamodb_connections_arn
    ]
  }
}

data "aws_iam_policy_document" "dynamodb_on_message_messages_policy" {
  statement {
    sid = "RoleForRemovingConnectionFromDynamoDB"
    actions = [
      "dynamodb:PutItem"
    ]
    effect = "Allow"
    resources = [
      var.dynamodb_messages_arn
    ]
  }
}

data "aws_iam_policy_document" "manage_connections_policy" {
  statement {
    sid = "RoleForManagingConnections"
    actions = [
      "execute-api:ManageConnections",
    ]
    effect = "Allow"
    resources = [
      format("arn:aws:execute-api:eu-west-2:%s:%s/production/*", data.aws_caller_identity.current.account_id, var.api_gateway_api_id)
    ]
  }
}
