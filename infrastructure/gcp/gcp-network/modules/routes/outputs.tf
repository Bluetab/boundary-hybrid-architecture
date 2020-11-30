
######
# google_compute_route
######

output "routes" {
  description = "The created routes resources"
  value       = google_compute_route.route
}
