# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = var.backend_bucket_name
    key    = var.eks_bucket_key_name
    region = var.aws_region
  }
}
