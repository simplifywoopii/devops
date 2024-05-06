resource "google_compute_subnetwork" "subnet" {
  name          = "${local.name}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.128.0.0/20"
}
