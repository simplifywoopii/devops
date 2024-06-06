# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "terraform-backend-simplifywoopii"
    prefix    = "vpc"
    # project = "devops-421112"
  }
}