remote_state{
    backend = "s3"

    generate = {
        path = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }

    config = {
        bucket = "apps-tf-states-bucket"
        key = "us-east-1/${path_relative_to_include()}/terraform.tfvars"
        region = "us-east-1"
        encrypt = false
        dynamodb_table = "course-lock-table"
        profile = "default"
    }
}

terraform{
    extra_arguments "variables" {
        commands = get_terraform_commands_that_need_vars()
        optional_var_files = [
            find_in_parent_folders("environment.tfvars", "ignore")
        ]
    }
}

generate "provider"{
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
        provider "aws" {
            profile = "default"
            region = "us-east-1"
        }
    EOF
}