locals {
  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  azs = var.azs

  # cluster info
  channel = "RAPID"
  datapath_provider = "ADVANCED_DATAPATH"
  default_max_pods_per_node = 110  
  database_encryption_state = "DECRYPTED"
  enable_shielded_nodes = true
}