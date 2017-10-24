# Configure the Google Cloud provider
provider "google" {
  credentials = "${file("/Users/asanuma/myreader-a4f88e1ea708.json")}"
  project = "myreader-1359"
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
      image = "debian-cloud/debian-8"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
