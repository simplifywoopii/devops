resource "google_container_cluster" "primary" {
  name       = local.cluster_name
  network    = data.terraform_remote_state.network.outputs.network_id
  subnetwork = data.terraform_remote_state.network.outputs.subnet_id

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }
  addons_config {
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }

    gcp_filestore_csi_driver_config {
      enabled = true
    }
  }

  binary_authorization {
    evaluation_mode = "DISABLED"
  }

  location                 = var.region
  min_master_version       = local.cluster_version
  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false
  node_locations      = local.azs
  release_channel {
    channel = local.channel
  }
  datapath_provider         = local.datapath_provider
  default_max_pods_per_node = local.default_max_pods_per_node

  private_cluster_config {
    enable_private_nodes = true
    master_global_access_config {
      enabled = true
    }
    master_ipv4_cidr_block = "172.16.0.0/28"
  }

  database_encryption {
    state = local.database_encryption_state
  }

  enable_shielded_nodes = local.enable_shielded_nodes

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS"
    ]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    managed_prometheus {
      enabled = true
    }
  }

  security_posture_config {
    mode               = "BASIC"
    vulnerability_mode = "VULNERABILITY_DISABLED"
  }

}
