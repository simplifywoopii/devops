resource "google_container_cluster" "primary" {
  name       = var.gke_cluster_name
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

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
  min_master_version       = var.gke_version
  remove_default_node_pool = true
  initial_node_count       = 1


  deletion_protection = false
  node_locations      = var.azs
  release_channel {
    channel = "RAPID"
  }
  datapath_provider         = "ADVANCED_DATAPATH"
  default_max_pods_per_node = 110

  private_cluster_config {
    enable_private_nodes = true
    master_global_access_config {
      enabled = true
    }
    master_ipv4_cidr_block = lookup(var.master, "master_ipv4_cidr_block", "")
  }

  database_encryption {
    state = "DECRYPTED"
  }

  enable_shielded_nodes = true
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
