resource "google_compute_router" "router" {
  depends_on = [google_container_node_pool.primary_nodes]
  name       = var.gke_router_name
  region     = google_compute_subnetwork.subnet.region
  network    = google_compute_network.vpc.id

  bgp {
    asn = 64514
  }
}
