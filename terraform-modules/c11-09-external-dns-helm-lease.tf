resource "helm_release" "ext_dns" {
  depends_on = [
    kubernetes_secret_v1.ext-dns-application-credentials,
  ]
  name       = "external-dns"
  namespace  = local.kube.external_dns.namespace
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "7.2.0"

  set {
    name  = "provider"
    value = "google"
  }

  set {
    name  = "google.zoneVisibility"
    value = "public"
  }

  set {

    name  = "txtOwnerId"
    value = "k8s"
  }

  set {
    name  = "serviceAccount.create"
    value = false
  }

  set {
    name  = "serviceAccount.name"
    value = local.kube.external_dns.service_account
  }

  set {
    name  = "google.serviceAccountSecret"
    value = local.kube.external_dns.credentials_sa_secret_key_name
  }
}
