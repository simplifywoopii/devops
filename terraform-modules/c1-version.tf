terraform {
  required_version = "~>1.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.25.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.29.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
  backend "gcs" {
  }
}
