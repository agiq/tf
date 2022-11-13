# Terraform HCL

provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile = "default"
}

resource "aws_instance" "ubuntu" {
  ami           = "ami-07d0cf3af28718ef8"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloTerraform"
  }
}