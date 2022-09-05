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

variable "lambda_functions" {
  type = map(object({
    iam_role_name : string
  }))
}

variable "api_gateway_role_name" {
  type = string
}

variable "dynamodb_messages_arn" {
  type = string
}