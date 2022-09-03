terraform {
  backend "s3" {
    bucket         = "terraform-state-evvzl7ombe"
    key            = "state/terraform-aws-chat/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    kms_key_id     = "alias/terraform-bucket-key"
    dynamodb_table = "terraform-aws-chat-state"
    profile        = "chat"
  }
}