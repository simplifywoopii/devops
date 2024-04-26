# # Resource: Helm Release 

# resource "helm_release" "argocd" {
#   depends_on   = [kubernetes_namespace_v1.argocd]
#   name         = "argocd"
#   repository   = "https://argoproj.github.io/argo-helm"
#   chart        = "argo-cd"
#   namespace    = kubernetes_namespace_v1.argocd.metadata.0.name
#   version      = "6.7.5"
#   force_update = true

#   values = ["${file("argocd_configuration/dev-values.yaml")}"]
#   set {
#     name = "nameOverride"
#     value = "argocd"
#   }
# }
