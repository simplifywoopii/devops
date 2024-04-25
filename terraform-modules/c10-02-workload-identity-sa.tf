resource "google_service_account" "workload_identity" {
  depends_on = [
    local.workload_identity,
    google_container_node_pool.primary_nodes
  ]
  account_id                   = "wid-gcpiam-sa"
  display_name                 = "GSA_NAME"
  project                      = var.project_id
  create_ignore_already_exists = true
  description                  = "service account for workload identity"
}


# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
resource "google_project_iam_binding" "workload_identity_binding" {
  depends_on = [google_service_account.workload_identity]
  project    = var.project_id
  role       = "roles/compute.viewer"
  members = [
    "serviceAccount:${google_service_account.workload_identity.email}"
  ]
}
