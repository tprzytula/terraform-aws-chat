data "archive_file" "disconnect_zip" {
  output_path = "modules/lambda/archives/lambda_function_disconnect.zip"
  source_dir  = "modules/lambda/sources/disconnect"
  type        = "zip"
}
