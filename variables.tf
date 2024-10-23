variable "aws_access_key" {
  type = string
}

variable "aws_access_secret" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "provider_acct_arn" {
  type = string
  description = "ARN of an external account trusted to assume role"
}