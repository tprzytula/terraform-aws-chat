resource "aws_iam_role" "disconnect_lambda_role" {
  name               = format("disconnect_lambda_role_%s", var.random_name)
  assume_role_policy = data.aws_iam_policy_document.basic_lambda_role.json
}

resource "aws_lambda_function" "disconnect" {
  filename         = "modules/lambda/archives/lambda_function_disconnect.zip"
  function_name    = format("disconnect_%s", var.random_name)
  description      = "Lambda API to handle WebSocket disconnections"
  role             = aws_iam_role.disconnect_lambda_role.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.disconnect_zip.output_base64sha256
  runtime          = "nodejs16.x"
  memory_size      = "128"
  publish          = true
  timeout          = 5
}
