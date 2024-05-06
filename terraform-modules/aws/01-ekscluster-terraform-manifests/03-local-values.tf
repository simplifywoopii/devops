# Define Local Values in Terraform
locals {
  owners      = var.owners
  environment = terraform.workspace
  name        = "${local.owners}-${var.environment}"

  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
  eks_cluster_name = "${local.name}-${var.cluster_name}"
}
