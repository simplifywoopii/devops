resource "kubernetes_annotations" "ext_dns" {
  depends_on  = [google_service_account_iam_policy.ext_dns]
  api_version = "v1"
  kind        = "ServiceAccount"
  metadata {
    name      = local.kube.external_dns.service_account
    namespace = local.kube.external_dns.namespace
  }
  annotations = {
    "iam.gke.io/gcp-service-account" = google_service_account.ext_dns_service_account.email
  }
}
