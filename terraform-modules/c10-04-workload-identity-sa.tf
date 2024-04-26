# resource "kubernetes_service_account_v1" "workload_identity" {
#   depends_on = [kubernetes_namespace_v1.workload_identity_ns]
#   metadata {
#     name      = local.workload_identity.service_account_name
#     namespace = local.workload_identity.service_account_namespace
#   }
# }
