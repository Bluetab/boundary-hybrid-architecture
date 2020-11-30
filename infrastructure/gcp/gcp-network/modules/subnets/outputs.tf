
######
# google_compute_subnetwork
######

output "subnets" {
  description = "The created subnet resources"
  value       = google_compute_subnetwork.subnetwork
}
