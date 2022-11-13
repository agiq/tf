terraform {
  backend "s3" {
    bucket = "apps-tf-states-bucket"
    dynamodb_table = "s3-state-lock"
    key = "s3_backend.tfstate"
    region = "us-east-1"
  }
}