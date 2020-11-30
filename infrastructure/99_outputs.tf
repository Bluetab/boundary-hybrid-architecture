output "boundary_lb" {
  value = module.aws.boundary_lb
}

output "target_ips" {
  value = concat(module.aws.target_ips, module.gcp.target_ips)
}

output "kms_recovery_key_id" {
  value = module.aws.kms_recovery_key_id
}

output "kms_worker_auth_key_id" {
  value = module.aws.kms_worker_auth_key_id
}

output "aws_secret_key_gcp_user" {
  sensitive = true
  value     = module.aws.aws_secret_key_gcp_user
}

output "aws_access_key_gcp_user" {
  sensitive = true
  value     = module.aws.aws_access_key_gcp_user
}
