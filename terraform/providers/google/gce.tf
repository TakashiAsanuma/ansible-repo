# Configure the Google Cloud provider
provider "google" {
  region = "asia-northeast1-b"
}

# Configure the Google Compute Engine Instance
resource "google_compute_instance" "default" {
  name = "test"
  machine_type = "f1-micro"
  zone = "asia-northeast1-b"
  tags = ["myreader"]

  boot_disk {
    initialize_params {
      image = "packer-1508896147"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
