resource "aws_iam_role" "lambda_roles" {
  for_each = local.lambda_functions

  name               = format("%s_lambda_role_%s", each.key, var.random_name)
  assume_role_policy = data.aws_iam_policy_document.basic_lambda_role.json
}

resource "aws_lambda_function" "lambda_functions" {
  for_each = local.lambda_functions

  filename         = each.value.output_path
  function_name    = format("%s_%s", each.key, var.random_name)
  role             = aws_iam_role.lambda_roles[each.key].arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda_zips[each.key].output_base64sha256
  runtime          = "nodejs16.x"
  memory_size      = "128"
  publish          = true
  timeout          = 5
}

