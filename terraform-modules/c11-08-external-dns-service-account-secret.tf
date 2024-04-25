resource "google_service_account_key" "ext_dns_sa_key" {
  depends_on         = [kubernetes_annotations.ext_dns]
  service_account_id = google_service_account.ext_dns_service_account.name
}

resource "kubernetes_secret_v1" "ext-dns-application-credentials" {
  depends_on = [google_service_account_key.ext_dns_sa_key]
  metadata {
    name      = local.kube.external_dns.credentials_sa_secret_key_name
    namespace = local.kube.external_dns.namespace
  }
  data = {
    "credentials.json" = base64decode(google_service_account_key.ext_dns_sa_key.private_key)
  }
}
