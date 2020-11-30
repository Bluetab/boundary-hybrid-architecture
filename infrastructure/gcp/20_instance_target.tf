resource "google_compute_instance" "target" {
  name         = format("%s-target", var.name)
  machine_type = "n1-standard-1"
  zone         = data.google_compute_zones.available.names.0

  tags = ["private"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.image_family.self_link
    }
  }

  network_interface {
    subnetwork = module.network.private_subnet_self_links.0
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa_boundary.pub")}"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
