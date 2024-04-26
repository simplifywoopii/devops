resource "google_compute_ssl_policy" "ssl-policy" {
  depends_on = [ kubernetes_secret_v1.ext-dns-application-credentials ]
  name            = "gke-ingress-ssl-policy"
  min_tls_version = "TLS_1_2"
  profile         = "MODERN"
  project         = var.project_id
}
