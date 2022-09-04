data "aws_iam_policy_document" "basic_lambda_role" {
  statement {
    sid = "RoleForBasicLambdaOperations"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
    effect = "Allow"
  }
}

data "archive_file" "lambda_zips" {
  for_each = local.lambda_functions

  source_dir  = each.value.source_dir
  output_path = each.value.output_path
  type        = "zip"
}
