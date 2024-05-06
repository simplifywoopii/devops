resource "kubernetes_namespace_v1" "external_dns_ns" {
  depends_on = [google_project_iam_binding.ext_dns]
  metadata {
    name = local.k8s.external_dns.ns
  }
}
