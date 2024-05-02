resource "google_compute_ssl_policy" "ssl-policy" {
  depends_on      = [kubernetes_secret_v1.ext-dns-application-credentials]
  name            = var.gke_ssl_policy_name
  min_tls_version = "TLS_1_2"
  profile         = "MODERN"
  project         = var.project_id
}


resource "google_compute_ssl_policy" "grafana-ssl-policy" {
  depends_on      = [kubernetes_secret_v1.ext-dns-application-credentials]
  name            = "grafana-ssl-policy"
  min_tls_version = "TLS_1_2"
  profile         = "MODERN"
  project         = var.project_id
}
