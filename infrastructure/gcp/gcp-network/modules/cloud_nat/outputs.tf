
######
# google_compute_router
######

output "router_names" {
  description = "The names of the routers"
  value       = google_compute_router.this.*.name
}

output "router_self_links" {
  description = "The self links of the routers"
  value       = google_compute_router.this.*.self_link
}

######
# google_compute_router_nat
######

output "nat_names" {
  description = "The names of the cloud NATs"
  value       = google_compute_router_nat.this.*.id
}
