
locals {
  public             = "public"
  private            = "private"
  private_restricted = "private-restricted"
}

resource "google_compute_firewall" "public_allow_all_inbound" {
  count = var.create_firewall ? 1 : 0

  name = format("%s-public-ngs", var.name)

  project = var.project_id
  network = var.network_name

  target_tags   = [local.public]
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]

  priority = "1000"

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "private_allow_all_network_inbound" {
  count = var.create_firewall ? 1 : 0

  name = format("%s-private-ngs", var.name)

  project = var.project_id
  network = var.network_name

  target_tags = [local.private]
  direction   = "INGRESS"

  source_ranges = var.subnetworks

  priority = "1000"

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "private_allow_restricted_network_inbound" {
  count = var.create_firewall ? 1 : 0

  name = format("%s-private-ngs02", var.name)

  project = var.project_id
  network = var.network_name

  target_tags = [local.private_restricted]
  direction   = "INGRESS"

  source_tags = [local.private, local.private_restricted]

  priority = "1000"

  allow {
    protocol = "all"
  }
}
