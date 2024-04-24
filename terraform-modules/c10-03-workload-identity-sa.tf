resource "kubernetes_service_account_v1" "this" {
  metadata {
    name = "wid-ksa"
    namespace = kubernetes_namespace_v1.this.metadata.0.name
  }
}