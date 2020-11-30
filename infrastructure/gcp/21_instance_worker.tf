data "google_compute_zones" "available" {
  region = var.region
}

data "google_compute_image" "image_family" {
  project = "ubuntu-os-cloud"
  family  = "ubuntu-1804-lts"
}

resource "google_compute_instance" "worker" {
  name         = format("%s-worker", var.name)
  machine_type = "n1-standard-1"
  zone         = data.google_compute_zones.available.names.0

  tags = ["public"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.image_family.self_link
    }
  }

  network_interface {
    subnetwork = module.network.public_subnet_self_links.0

    access_config {} //External and ephemeral IP
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa_boundary.pub")}"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa_boundary")
    host        = self.network_interface.0.access_config.0.nat_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /etc/pki/tls/boundary",
      "echo '${var.tls_private_key_pem}' | sudo tee ${var.tls_key_path}",
      "echo '${var.tls_self_cert_pem}' | sudo tee ${var.tls_cert_path}",
    ]
  }

  provisioner "file" {
    source      = "${var.boundary_bin}/boundary"
    destination = "~/boundary"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv ~/boundary /usr/local/bin/boundary",
      "sudo chmod 0755 /usr/local/bin/boundary",
    ]
  }

  provisioner "file" {
    content = templatefile("${path.module}/install/worker.hcl.tpl", {
      controller_ips         = var.controllers_dns
      name_suffix            = "gcp"
      public_ip              = self.network_interface.0.access_config.0.nat_ip
      private_ip             = self.network_interface.0.network_ip
      tls_disabled           = var.tls_disabled
      tls_key_path           = var.tls_key_path
      tls_cert_path          = var.tls_cert_path
      kms_type               = var.kms_type
      kms_worker_auth_key_id = var.kms_key_id
      region                 = var.aws_region
      access_key             = var.aws_access_key
      secret_key             = var.aws_secret_key
    })
    destination = "~/boundary-worker.hcl"
  }

  provisioner "remote-exec" {
    inline = ["sudo mv ~/boundary-worker.hcl /etc/boundary-worker.hcl"]
  }

  provisioner "file" {
    source      = "${path.module}/install/install.sh"
    destination = "~/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 0755 ~/install.sh",
      "sudo ~/./install.sh worker"
    ]
  }
}
