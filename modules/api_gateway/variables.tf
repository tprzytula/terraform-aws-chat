variable "random_name" {
  description = "Random string to add to names for this environment."
  type        = string
}

variable "lambda_function_connect" {
  type = object({
    arn           = string
    function_name = string
  })
}

variable "lambda_function_disconnect" {
  type = object({
    arn           = string
    function_name = string
  })
}

variable "lambda_function_message" {
  type = object({
    arn           = string
    function_name = string
  })
}
