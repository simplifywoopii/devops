resource "google_compute_address" "static" {
  name = "gke-ingress-extip1"
  # prefix_length = 29
  address_type = "EXTERNAL"
  # network = google_compute_network.vpc.self_link
}
