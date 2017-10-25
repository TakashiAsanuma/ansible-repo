# Configure the Google Cloud provider
provider "google" {
  region = "asia-northeast1"
}

resource "google_compute_http_health_check" "default" {
  name         = "authentication-health-check"
  request_path = "/"

  timeout_sec        = 5
  check_interval_sec = 10
}

resource "google_compute_instance_template" "webserver" {
  name_prefix    = "webserver-template-"
  machine_type   = "f1-micro"
  can_ip_forward = false

  tags = ["http-server", "https-server"]

  disk {
    source_image = "packer-1508896147"
  }

  network_interface {
    network = "default"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_target_pool" "webserver" {
  name = "webserver"

  health_checks = [
    "${google_compute_http_health_check.default.name}",
  ]
}

resource "google_compute_instance_group_manager" "webserver" {
  name = "webserver"
  zone = "asia-northeast1-b"

  instance_template  = "${google_compute_instance_template.webserver.self_link}"
  target_pools       = ["${google_compute_target_pool.webserver.self_link}"]
  base_instance_name = "web"
}

resource "google_compute_autoscaler" "webserver" {
  name   = "scaler"
  zone   = "asia-northeast1-b"
  target = "${google_compute_instance_group_manager.webserver.self_link}"

  autoscaling_policy = {
    max_replicas    = 5
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}
