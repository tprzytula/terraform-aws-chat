data "aws_iam_policy_document" "basic_logs_policy" {
  statement {
    sid = "RoleForBasicLambdaLogs"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    effect = "Allow"
    resources = [
      "*"
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
