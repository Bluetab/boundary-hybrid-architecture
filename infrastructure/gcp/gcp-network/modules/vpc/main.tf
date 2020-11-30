
resource "google_compute_network" "network" {
  count = var.create_vpc ? 1 : 0

  name = var.name

  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  project                         = var.project_id
  description                     = var.description
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

resource "google_compute_shared_vpc_host_project" "this" {
  count   = var.shared_vpc_host ? 1 : 0
  project = var.project_id

  depends_on = [google_compute_network.network]
}
