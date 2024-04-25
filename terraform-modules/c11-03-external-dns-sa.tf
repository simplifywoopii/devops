resource "google_service_account" "ext_dns_service_account" {
  depends_on                   = [google_project_iam_binding.workload_identity]
  account_id                   = "external-dns-sa"
  display_name                 = "external-dns-sa"
  project                      = var.project_id
  create_ignore_already_exists = true
  description                  = "service account for external dns"
}


# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
resource "google_project_iam_binding" "ext_dns" {
  depends_on = [google_service_account.ext_dns_service_account]
  project    = var.project_id
  role       = "roles/dns.admin"
  members = [
    "serviceAccount:${google_service_account.ext_dns_service_account.email}"
  ]
}
