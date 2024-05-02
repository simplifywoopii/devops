data "google_iam_policy" "ext_dns" {
  depends_on = [kubernetes_service_account_v1.ext_dns]
  binding {
    role = "roles/iam.workloadIdentityUser"

    members = [
      "serviceAccount:${var.project_id}.svc.id.goog[${local.k8s.external_dns.ns}/${local.k8s.external_dns.sa}]",
    ]
  }
}



resource "google_service_account_iam_policy" "ext_dns" {
  depends_on         = [data.google_iam_policy.ext_dns]
  service_account_id = google_service_account.ext_dns_service_account.name
  policy_data        = data.google_iam_policy.ext_dns.policy_data
}

