resource "kubernetes_service_account_v1" "ext_dns" {
  depends_on = [kubernetes_namespace_v1.external_dns_ns]
  metadata {
    name      = local.kube.external_dns.service_account
    namespace = local.kube.external_dns.namespace
  }
}
