locals {
  boundary_lb         = data.terraform_remote_state.infrastructure.outputs.boundary_lb
  target_ips          = data.terraform_remote_state.infrastructure.outputs.target_ips
  kms_recovery_key_id = data.terraform_remote_state.infrastructure.outputs.kms_recovery_key_id

  aws_access_key = data.terraform_remote_state.infrastructure.outputs.aws_access_key_gcp_user
  aws_secret_key = data.terraform_remote_state.infrastructure.outputs.aws_secret_key_gcp_user
}

module "boundary" {
  source              = "./boundary"
  url                 = format("http://%s:9200", local.boundary_lb)
  target_ips          = local.target_ips
  kms_recovery_key_id = local.kms_recovery_key_id

  aws_region     = "eu-west-1"
  aws_access_key = local.aws_access_key
  aws_secret_key = local.aws_secret_key
}

terraform {
  backend "s3" {
    bucket                  = "example-tfstate"
    key                     = "hashicorp-boundary-configuration.tfstate"
    workspace_key_prefix    = "workspaces"
    region                  = "eu-west-1"
    encrypt                 = true
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "example-aws-profile"
  }
}

data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config = {
    bucket                  = "example-tfstate"
    key                     = "hashicorp-boundary-infrastructure.tfstate"
    workspace_key_prefix    = "workspaces"
    region                  = "eu-west-1"
    encrypt                 = true
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "example-aws-profile"
  }
}
