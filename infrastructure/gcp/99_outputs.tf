output "target_ips" {
  description = "IPs of the targets located in GCP"
  value       = google_compute_instance.target.*.network_interface.0.network_ip
}
