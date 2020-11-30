
resource "google_compute_router" "this" {
  count = var.create_vpc && var.enable_nat_gateway ? length(var.subnetworks) : 0

  name = format("%s-private-router%.2d", var.name, count.index + 1)

  description = var.description
  project     = var.project_id
  network     = var.network_name
  region      = values(var.subnetworks[count.index]).0

  bgp {
    asn = var.router_asn
  }
}

resource "google_compute_router_nat" "this" {
  count = var.create_vpc && var.enable_nat_gateway ? length(var.subnetworks) : 0

  name = format("%s-private-nat%.2d", var.name, count.index + 1)

  project                            = var.project_id
  region                             = values(var.subnetworks[count.index]).0
  router                             = google_compute_router.this[count.index].name
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  nat_ips                            = var.nat_ips
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  min_ports_per_vm                   = var.min_ports_per_vm
  udp_idle_timeout_sec               = var.udp_idle_timeout_sec
  icmp_idle_timeout_sec              = var.icmp_idle_timeout_sec
  tcp_established_idle_timeout_sec   = var.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec    = var.tcp_transitory_idle_timeout_sec

  dynamic "subnetwork" {
    for_each = var.nat_subnetworks

    content {
      name                    = nat_subnetworks.value.name
      source_ip_ranges_to_nat = nat_subnetworks.value.source_ip_ranges_to_nat
    }
  }

  dynamic "log_config" {
    for_each = var.log_config_enable == true ? [{
      enable = var.log_config_enable
      filter = var.log_config_filter
    }] : []

    content {
      enable = log_config.value.enable
      filter = log_config.value.filter
    }
  }
}
