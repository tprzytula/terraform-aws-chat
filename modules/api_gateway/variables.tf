variable "random_name" {
  description = "Random string to add to names for this environment."
  type        = string
}

variable "lambda_functions" {
  type = map(object({
    arn : string,
    function_name : string
    route_key : string
  }))
}