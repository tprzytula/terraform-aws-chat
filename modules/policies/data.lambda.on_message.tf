data "aws_iam_policy_document" "dynamodb_scan_policy" {
  statement {
    sid = "RoleForRemovingConnectionFromDynamoDB"
    actions = [
      "dynamodb:Scan",
    ]
    effect = "Allow"
    resources = [
      var.dynamodb_connections_arn
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
      // arn:aws:execute-api:eu-west-2:428187061570:arn:aws:apigateway:eu-west-2::/apis/fep251gesk/production/*
      format("arn:aws:execute-api:eu-west-2:%s:%s/production/*", data.aws_caller_identity.current.account_id, var.api_gateway_api_id)
    ]
  }
}
