resource "kubernetes_service_account_v1" "ext_dns" {
  depends_on = [kubernetes_namespace_v1.external_dns_ns]
  metadata {
    name      = local.k8s.external_dns.sa
    namespace = local.k8s.external_dns.ns
  }
}
