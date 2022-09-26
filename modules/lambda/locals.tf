locals {
  root_directory        = "modules/lambda"
  source_root_directory = format("%s/sources", local.root_directory)
  output_root_directory = format("%s/archives", local.root_directory)

  lambda_functions = {
    "connect" = {
      source_dir  = format("%s/connect", local.source_root_directory)
      output_path = format("%s/connect.zip", local.output_root_directory)
      route_key   = "$connect"
    },
    "disconnect" = {
      source_dir  = format("%s/disconnect", local.source_root_directory)
      output_path = format("%s/disconnect.zip", local.output_root_directory)
      route_key   = "$disconnect"
    },
    "message" = {
      source_dir  = format("%s/message", local.source_root_directory)
      output_path = format("%s/message.zip", local.output_root_directory)
      route_key   = "message"
    }
    "remove" = {
      source_dir  = format("%s/remove", local.source_root_directory)
      output_path = format("%s/remove.zip", local.output_root_directory)
      route_key   = "remove"
    }
  }
}
