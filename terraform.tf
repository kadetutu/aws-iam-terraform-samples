terraform{
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_access_secret
}