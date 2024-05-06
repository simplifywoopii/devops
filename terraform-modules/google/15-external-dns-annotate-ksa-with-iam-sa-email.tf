resource "kubernetes_annotations" "ext_dns" {
  depends_on  = [google_service_account_iam_policy.ext_dns]
  api_version = "v1"
  kind        = "ServiceAccount"
  metadata {
    name      = local.k8s.external_dns.sa
    namespace = local.k8s.external_dns.ns
  }
  annotations = {
    "iam.gke.io/gcp-service-account" = google_service_account.ext_dns_service_account.email
  }
}
