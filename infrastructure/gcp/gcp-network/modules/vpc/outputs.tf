
######
# google_compute_network
######

output "id" {
  description = "An identifier of the network resource"
  value       = concat(google_compute_network.network.*.id, [""])[0]
}

output "name" {
  description = "The name of the network resource"
  value       = concat(google_compute_network.network.*.name, [""])[0]
}

output "self_link" {
  description = "The URI of the network resource"
  value       = concat(google_compute_network.network.*.self_link, [""])[0]
}
