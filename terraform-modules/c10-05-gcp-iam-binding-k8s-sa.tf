data "google_iam_policy" "this" {
  binding {
    role = "roles/iam.workloadIdentityUser"

    members = [
      "serviceAccount:${var.project_id}.svc.id.goog[${local.workload_identity.service_account_namespace}/${local.workload_identity.service_account_name}]",
    ]
  }
}



resource "google_service_account_iam_policy" "this" {
  service_account_id = google_service_account.service_account.name
  policy_data        = data.google_iam_policy.this.policy_data
}

