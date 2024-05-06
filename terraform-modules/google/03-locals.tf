locals {
  owners      = var.owners
  environment = terraform.workspace
  name        = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
    name        = local.name
  }
  k8s = {
    external_dns = {
      ns                             = "external-dns-ns"
      sa                             = "external-dns-ksa"
      credentials_sa_secret_key_name = "external-dns-sa-credentials"
    }
  }

  gke = {
    external_dns = {
      name      = "external-dns-sa"
      disp_name = "external-dns-sa"
    }
  }
}
