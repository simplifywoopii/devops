resource "helm_release" "argocd" {
  depends_on       = [helm_release.external_dns]
  name             = var.helm_argocd_name
  namespace        = var.helm_argocd_namespace
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "6.7.15"
  create_namespace = true

  set {
    name  = "global.domain"
    value = var.helm_argocd_global_domain
  }

  set {
    name  = "configs.params.server\\.insecure"
    value = true
  }

  set {
    name  = "server.ingress.enabled"
    value = true
  }

  set {
    name  = "server.ingress.controller"
    value = "gke"
  }

  set {
    name  = "server.ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "gce"
  }

  set {
    name  = "server.ingress.annotations.external-dns\\.alpha\\.kubernetes\\.io/hostname"
    value = var.helm_argocd_global_domain
  }

  set {
    name  = "server.ingress.ingressClassName"
    value = "gce"
  }

  set {
    name  = "server.ingress.path"
    value = "/"
  }

  set {
    name  = "server.ingress.pathType"
    value = "Prefix"
  }

  set {
    name  = "server.ingress.gke.frontendConfig.redirectToHttps.enabled"
    value = true
  }

  set {
    name  = "server.ingress.gke.frontendConfig.sslPolicy"
    value = var.gke_ssl_policy_name
  }
}
