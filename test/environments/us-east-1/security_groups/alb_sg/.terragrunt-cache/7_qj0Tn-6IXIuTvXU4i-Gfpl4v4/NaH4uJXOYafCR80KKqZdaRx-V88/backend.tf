# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "apps-tf-states-bucket"
    dynamodb_table = "course-lock-table"
    encrypt        = false
    key            = "us-east-1/security_groups/alb_sg/terraform.tfvars"
    profile        = "default"
    region         = "us-east-1"
  }
}
