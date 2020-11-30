provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "example-aws-profile"
}


provider "google" {
  credentials = file("~/.gcp/example-gcp-credentials.json")
  project     = "example-gcp-project"
  region      = var.gcp_region
  zone        = var.gcp_zone
}


terraform {
  backend "s3" {
    bucket                  = "example-tfstate"
    key                     = "hashicorp-boundary-infrastructure.tfstate"
    workspace_key_prefix    = "workspaces"
    region                  = "eu-west-1"
    encrypt                 = true
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "example-aws-profile"
  }
}
