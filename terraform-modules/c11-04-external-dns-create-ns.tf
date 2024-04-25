resource "kubernetes_namespace_v1" "external_dns_ns" {
  metadata {
    name = "${local.kube.external_dns.namespace}"
  }
}