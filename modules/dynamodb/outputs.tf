output "connections_arn" {
  value = aws_dynamodb_table.connections.arn
}
output "messages_arn" {
  value = aws_dynamodb_table.messages.arn
}
