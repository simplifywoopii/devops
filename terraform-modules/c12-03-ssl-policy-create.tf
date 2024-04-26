resource "google_compute_ssl_policy" "ssl-policy" {
  depends_on = [ helm_release.ext_dns ]
  name            = "gke-ingress-ssl-policy"
  min_tls_version = "TLS_1_2"
  profile         = "MODERN"
  project         = var.project_id
}
