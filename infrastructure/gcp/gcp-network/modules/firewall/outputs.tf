
######
# google_compute_firewall
######

output "public" {
  description = "The instance tag indicating network public topology"
  value       = local.public
}

output "private_restricted" {
  description = "The instance tag indicating network restricted topology"
  value       = local.private_restricted
}

output "private" {
  description = "The instance tag indicating network private topology"
  value       = local.private
}
