variable "random_name" {
  description = "Random string to add to names for this environment."
  type        = string
}

variable "api_gateway_api_id" {
  type = string
}

variable "dynamodb_connections_arn" {
  type = string
}

variable "connect_lambda_role_name" {
  type = string
}

variable "disconnect_lambda_role_name" {
  type = string
}

variable "message_lambda_role_name" {
  type = string
}

variable "api_gateway_role_name" {
  type = string
}
