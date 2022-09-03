data "archive_file" "message_zip" {
  output_path = "modules/lambda/archives/lambda_function_message.zip"
  source_dir  = "modules/lambda/sources/message"
  type        = "zip"
}
