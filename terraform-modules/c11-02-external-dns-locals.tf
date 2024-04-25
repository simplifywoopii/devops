locals {
  kube = {
    external_dns = {
      namespace                      = var.external_dns_namespace
      service_account                = "external-dns-ksa"
      credentials_sa_secret_key_name = "external-dns-sa-credentials"
    }
  }
  sa = {
    external_dns = {
      name      = var.external_dns_service_account
      disp_name = var.external_dns_service_account_disp_name
    }
  }
}
