# resource "kubernetes_namespace_v1" "workload_identity_ns" {
#   depends_on = [google_project_iam_binding.workload_identity_binding]
#   metadata {
#     name = local.workload_identity.service_account_namespace
#   }
# }
