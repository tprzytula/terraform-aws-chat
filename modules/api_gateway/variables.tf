variable "random_name" {
    type=string
}
variable "lambda_functions" {
  type = map(object({
        invoke_arn : string,
        function_name : string
        route_key : string
    }))
}
