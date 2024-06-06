resource "google_compute_network" "network" {
  name                    = "${local.name}-network"
  auto_create_subnetworks = false
}