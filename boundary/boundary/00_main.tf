terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "0.1.0"
    }
  }
}

provider "boundary" {
  addr             = var.url
  recovery_kms_hcl = <<EOT
    kms "awskms" {
      purpose    = "recovery"
      key_id     = "global_root"
      region     = "${var.aws_region}"
      access_key = "${var.aws_access_key}"
      secret_key = "${var.aws_secret_key}"
      kms_key_id = "${var.kms_recovery_key_id}"
    }
EOT
}
