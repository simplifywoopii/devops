variable "owners" {
  description = "owner"
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "azs" {
  description = "available zones"
  default = [
    "us-central1-a",
    "us-central1-b",
    "us-central1-c",
  ]
}

variable "gke_cluster_name" {
  description = "gke cluster name"
}

variable "gke_num_nodes" {
  description = "number of gke nodes"
}

variable "gke_version" {
  type = string
}

variable "gke_machine_type" {
  description = "machine type of gke nodes"
}

variable "gke_master_sa_email" {
  description = "gke master service account email"
}

variable "gke_router_name" {
  description = "gke router name"
}

variable "gke_router_nat_name" {
  description = "google compute router nat gateway name"
}

variable "gke_argocd_ssl_policy_name" {
  description = "google compute ssl policy"
}

variable "gke_grafana_ssl_policy_name" {
  description = "google compute ssl policy"
}

variable "helm_external_dns_name" {
  description = "helm externaldns name"
}

variable "helm_argocd_name" {
  description = "helm argocd name"
}

variable "helm_argocd_namespace" {
  description = "helm argocd namespace"
}

variable "helm_argocd_global_domain" {
  description = "helm argocd global domain"
}



variable "master" {
  type = map(string)
  default = {
    "master_ipv4_cidr_block" = "172.16.0.0/28"
  }
}
