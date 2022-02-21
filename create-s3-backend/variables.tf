variable "aws-region" {
  description = "Value of the of the S3 bucket"
  type        = string
  default     = "us-west-2"
}

variable "aws_dynamodb_table" {
  description = "the name of the DynamoDB table"
  type        = string
  default     = "umcs-remote-state-lock"
}

