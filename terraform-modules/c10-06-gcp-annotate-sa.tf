resource "kubernetes_annotations" "workload_identity" {
  api_version = "v1"
  kind = "ServiceAccount"
  metadata {
    name = "${local.workload_identity.service_account_name}"
    namespace = "${local.workload_identity.service_account_namespace}"
  }
  annotations = {
    "iam.gke.io/gcp-service-account" = google_service_account.service_account.email
  }
}