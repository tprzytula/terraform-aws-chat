data "archive_file" "connect_zip" {
  output_path = "modules/lambda/archives/lambda_function_connect.zip"
  source_dir  = "modules/lambda/sources/connect"
  type        = "zip"
}
