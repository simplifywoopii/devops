# data "google_iam_policy" "workload_identity" {
#   depends_on = [kubernetes_service_account_v1.workload_identity]
#   binding {
#     role = "roles/iam.workloadIdentityUser"

#     members = [
#       "serviceAccount:${var.project_id}.svc.id.goog[${local.workload_identity.service_account_namespace}/${local.workload_identity.service_account_name}]",
#     ]
#   }
# }



# resource "google_service_account_iam_policy" "workload_identity" {
#   depends_on         = [data.google_iam_policy.workload_identity]
#   service_account_id = google_service_account.workload_identity.name
#   policy_data        = data.google_iam_policy.workload_identity.policy_data
# }

