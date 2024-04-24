resource "google_service_account" "service_account" {
  account_id   = "wid-gcpiam-sa"
  display_name = "GSA_NAME"
  project = var.project_id
  create_ignore_already_exists = true
  description = "service account for workload identity"
  depends_on = [ google_container_cluster.primary, google_container_node_pool.primary_nodes ]
}


# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
resource "google_service_account_iam_binding" "this" {
  service_account_id = google_service_account.service_account.name
  role = "roles/viewer"
  members = [ 
    "serviceAccount:${google_service_account.service_account.email}"
   ]
}