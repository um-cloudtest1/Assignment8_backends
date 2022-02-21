# Terraform starter code for Cloud Computing Assignment 8 on Terraform backends.
# Based on 
#  Brikman, Yevgeniy. Terraform: Up & Running (p. 112). O'Reilly Media. Kindle Edition. 
# and on 
#  https://www.techcrumble.net/2020/01/how-to-configure-terraform-aws-backend-with-s3-and-dynamodb-table/

provider "aws" {
  region = var.aws-region
}

resource "random_id" "tc-rmstate" {
  byte_length = 2
}

resource "aws_s3_bucket" "tfrmstate" {
  bucket = "tc-remotestate-${random_id.tc-rmstate.dec}"
  lifecycle { # To destroy, comment out this section 
    prevent_destroy = true
  }

  tags = {
    Owner      = "Alden Wright"
    Course     = "UMCS cloud computing"
    Assignment = 8
    Name       = "tf backend creation"
  }
}

resource "aws_s3_object" "rmstate_folder" {
  bucket = aws_s3_bucket.tfrmstate.id
  key    = "terraform-aws/"
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = var.aws_dynamodb_table
  read_capacity  = 20 # max of reads/second for items up to 1 KB in size
  write_capacity = 20 # max of writes/second for items up to 1 KB in size
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
