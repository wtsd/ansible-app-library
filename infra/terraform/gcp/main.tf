terraform {
  required_version = ">= 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "app" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {}
  }

  labels = {
    env  = var.env
    role = "app"
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.public_key_path)}"
  }
}

output "nat_ip" {
  value = google_compute_instance.app.network_interface[0].access_config[0].nat_ip
}

output "generated_inventory" {
  value = <<EOT
[app]
${google_compute_instance.app.network_interface[0].access_config[0].nat_ip} ansible_user=${var.ssh_user}

[all:vars]
env=${var.env}
EOT
}
