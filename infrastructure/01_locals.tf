locals {
  aws_region = data.aws_region.current.name

  aws_tags = {
    "region"     = local.aws_region
    "repository" = var.name
    "branch"     = var.branch
    "backend"    = var.backend
    "terraform"  = "true"
  }
  gcp_labels = {
    "region"     = var.gcp_region
    "zone"       = var.gcp_zone
    "repository" = var.name
    "branch"     = var.branch
    "backend"    = var.backend
    "terraform"  = "true"
  }
}

data "aws_region" "current" {}
