
module "aws" {
  source = "./aws"

  pub_ssh_key_path  = "~/.ssh/id_rsa_boundary.pub"
  priv_ssh_key_path = "~/.ssh/id_rsa_boundary"

  name = var.name
  tags = local.aws_tags
}

module "gcp" {
  source = "./gcp"

  name            = var.name
  region          = var.gcp_region
  controllers_dns = [module.aws.boundary_lb]
  kms_key_id      = module.aws.kms_worker_auth_key_id

  aws_region     = local.aws_region
  aws_access_key = module.aws.aws_access_key_gcp_user
  aws_secret_key = module.aws.aws_secret_key_gcp_user

  tls_private_key_pem = module.aws.tls_private_key_pem
  tls_self_cert_pem   = module.aws.tls_self_cert_pem

  labels = local.gcp_labels
}
