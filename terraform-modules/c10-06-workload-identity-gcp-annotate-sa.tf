resource "kubernetes_annotations" "workload_identity" {
  depends_on  = [google_service_account_iam_policy.workload_identity]
  api_version = "v1"
  kind        = "ServiceAccount"
  metadata {
    name      = local.workload_identity.service_account_name
    namespace = local.workload_identity.service_account_namespace
  }
  annotations = {
    "iam.gke.io/gcp-service-account" = google_service_account.workload_identity.email
  }
}
