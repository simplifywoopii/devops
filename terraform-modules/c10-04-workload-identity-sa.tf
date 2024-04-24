resource "kubernetes_service_account_v1" "this" {
  metadata {
    name = "${local.workload_identity.service_account_name}"
    namespace = "${local.workload_identity.service_account_namespace}"
  }
}