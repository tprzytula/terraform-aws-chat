resource "aws_iam_role" "connect_lambda_role" {
  name               = format("connect_lambda_role_%s", var.random_name)
  assume_role_policy = data.aws_iam_policy_document.basic_lambda_role.json
}

resource "aws_lambda_function" "connect" {
  filename         = "modules/lambda/archives/lambda_function_connect.zip"
  function_name    = format("connect_%s", var.random_name)
  description      = "Lambda API to handle WebSocket connections"
  role             = aws_iam_role.connect_lambda_role.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.connect_zip.output_base64sha256
  runtime          = "nodejs16.x"
  memory_size      = "128"
  publish          = true
  timeout          = 5
}
