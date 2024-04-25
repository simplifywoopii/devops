# resource "google_compute_router" "router" {
#   name    = "gke-us-central1-cloud-router"
#   region  = google_compute_subnetwork.subnet.region
#   network = google_compute_network.vpc.id

#   bgp {
#     asn = 64514
#   }
# }