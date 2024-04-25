resource "helm_release" "ext_dns" {
  depends_on = [ 
    google_service_account.ext_dns_service_account,
    google_project_iam_binding.ext_dns,
    kubernetes_namespace_v1.external_dns_ns,
    kubernetes_service_account_v1.ext_dns,
    data.google_iam_policy.ext_dns,
    google_service_account_iam_policy.ext_dns,
    kubernetes_annotations.ext_dns,
    ]
  name       = "external-dns"
  namespace = "${local.kube.external_dns.namespace}"
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
    value = "${local.kube.external_dns.service_account}"
  }

  set {
    name = "google.serviceAccountSecretKey"
    value = file("../credentials.json")
  }
}