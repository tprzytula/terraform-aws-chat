data "aws_iam_policy_document" "api_gateway_logs_policy" {
  statement {
    sid = "AllowAllActionsOnLogs"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}
