locals {
  kube = {
    external_dns = {
      namespace = var.external_dns_namespace
      service_account = "external-dns-ksa"
    }
  }
  sa = {
    external_dns = {
      name = var.external_dns_service_account
      disp_name = var.external_dns_service_account_disp_name
    }
  }
}