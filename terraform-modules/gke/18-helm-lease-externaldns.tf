resource "helm_release" "external_dns" {
  depends_on       = [google_compute_ssl_policy.ssl-policy]
  name             = var.helm_external_dns_name
  namespace        = local.k8s.external_dns.ns
  timeout = 60
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "external-dns"
  version          = "7.2.0"
  create_namespace = true

  set {
    name  = "provider"
    value = "google"
  }

  set {
    name  = "google.zoneVisibility"
    value = "public"
  }

  set {
    name  = "google.serviceAccountSecret"
    value = local.k8s.external_dns.credentials_sa_secret_key_name
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
    value = local.k8s.external_dns.sa
  }
}
