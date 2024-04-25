data "google_iam_policy" "ext_dns" {
  binding {
    role = "roles/iam.workloadIdentityUser"

    members = [
      "serviceAccount:${var.project_id}.svc.id.goog[${local.kube.external_dns.namespace}/${local.kube.external_dns.service_account}]",
    ]
  }
}



resource "google_service_account_iam_policy" "ext_dns" {
  service_account_id = google_service_account.ext_dns_service_account.name
  policy_data = data.google_iam_policy.ext_dns.policy_data
}

