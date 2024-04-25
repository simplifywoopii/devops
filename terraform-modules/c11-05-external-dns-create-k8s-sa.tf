resource "kubernetes_service_account_v1" "ext_dns" {
  metadata {
    name = "${local.kube.external_dns.service_account}"
    namespace = "${local.kube.external_dns.namespace}"
  }
}