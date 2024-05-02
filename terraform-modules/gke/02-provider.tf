provider "google" {
  project     = var.project_id
  region      = var.region
}


data "google_client_config" "default" {}

data "google_container_cluster" "this" {
  name = google_container_cluster.primary.name
}

provider "kubernetes" {
  # Configuration options
  host  = "https://${data.google_container_cluster.this.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = []
    command     = "gke-gcloud-auth-plugin"
  }
}


provider "helm" {
  # Configuration options
  kubernetes {
    host  = "https://${data.google_container_cluster.this.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = []
      command     = "gke-gcloud-auth-plugin"
    }
  }
}
