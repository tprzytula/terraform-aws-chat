resource "aws_dynamodb_table" "messages" {
  name           = "messages"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"
  range_key      = "message"

  attribute {
    name = "id"
    type = "S"
  }
  attribute {
    name = "message"
    type = "S"
  }

}
