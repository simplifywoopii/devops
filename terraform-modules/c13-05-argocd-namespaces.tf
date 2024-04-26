# Resource: Kubernetes Namespace ns-app1
resource "kubernetes_namespace_v1" "argocd" {
  depends_on = [ google_compute_ssl_policy.ssl-policy ]
  metadata {
    name = "argocd"
  }
}
