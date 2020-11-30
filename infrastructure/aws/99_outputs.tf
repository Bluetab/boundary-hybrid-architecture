output "boundary_lb" {
  description = "Load balancer for boundary controllers"
  value       = aws_lb.controller.dns_name
}

output "target_ips" {
  description = "IPs of the targets located in AWS"
  value       = aws_instance.target.*.private_ip
}

output "kms_recovery_key_id" {
  description = "KMS Recovery key ID"
  value       = aws_kms_key.recovery.id
}

output "kms_worker_auth_key_id" {
  description = "KMS Worker Auth key ID"
  value       = aws_kms_key.worker_auth.id
}

output "tls_private_key_pem" {
  description = "Private key used for generating ACM certificate"
  value       = tls_private_key.boundary.private_key_pem
}

output "tls_self_cert_pem" {
  description = "Self signed certificate used for generating ACM certificate"
  value       = tls_self_signed_cert.boundary.cert_pem
}

output "aws_access_key_gcp_user" {
  description = "Access key of the generated IAM User for the GCP Workers"
  value       = aws_iam_access_key.gcp_worker.id
}

output "aws_secret_key_gcp_user" {
  description = "Secret key of the generated IAM User for the GCP Workers"
  value       = aws_iam_access_key.gcp_worker.secret
}


