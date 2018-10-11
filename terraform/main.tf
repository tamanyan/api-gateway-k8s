# To account setting
provider "google" {
  credentials = "${file("./service-account.json")}"
  project     = "${var.project}"
}

###
resource "google_container_cluster" "gke" {
  name               = "${var.cluster_name}"
  zone               = "${var.zone}"
  network            = "${var.network}"
  initial_node_count = "${var.initial_node_count}"
  description        = "${var.description}"

  min_master_version = "${var.min_master_version}"
  node_version       = "${var.node_version}"

  node_config {
    machine_type = "${var.machine_type}"
    disk_size_gb = "${var.disk_size}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  master_auth {
    username = "${var.master_auth_username}"
    password = "${var.master_auth_password}"
  }
}
