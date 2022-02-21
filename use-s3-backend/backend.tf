terraform {
  backend "s3" {
    bucket         = "tc-remotestate-52661"
    key            = "terraform-aws/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "umcs-remote-state-lock"
  }
}
