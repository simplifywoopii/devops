variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "azs" {
  description = "available zones"
}

variable "gke_num_nodes" {
  default     = 3
  description = "number of gke nodes"
}

variable "gke_machine_type" {
  default     = "n1-standard-2"
  description = "machine type of gke nodes"
}

variable "owners" {
  description = "owner"
}

variable "master" {
  type = map(string)
  default = {
    "master_ipv4_cidr_block" = "172.16.0.0/28"
  }
}
