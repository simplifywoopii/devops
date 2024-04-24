resource "kubernetes_namespace_v1" "this" {
  metadata {
    name = "${local.workload_identity.service_account_namespace}"
  }
}