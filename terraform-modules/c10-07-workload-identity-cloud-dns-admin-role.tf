resource "google_project_iam_binding" "workload_identity" {
  depends_on = [kubernetes_annotations.workload_identity]
  project    = var.project_id
  role       = "roles/dns.admin"
  members = [
    "serviceAccount:${google_service_account.workload_identity.email}"
  ]
}
