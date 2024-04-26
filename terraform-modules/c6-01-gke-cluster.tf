# "remove_default_node_pool"
# Cluster는 default node pool 없이 생성이 불가능함
# 그래서 remove_default_node_pool 값을 "true"로 설정하면 default node pool을 작게 생성한 뒤 바로 삭제
resource "google_container_cluster" "primary" {
  name       = "${local.name}-gke"
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
    
  }
 

  addons_config {
    # httpLoadBalancing: default: enable
    # horizontalPodAutoscaling: default: enable
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }

    gcp_filestore_csi_driver_config {
      enabled = true
    }
  }
  # ip_allocation_policy {
  #   stack_type              = "IPV4"
  #   cluster_ipv4_cidr_block = lookup(var.master, "master_ipv4_cidr_block", "")

  # }

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



  datapath_provider = "ADVANCED_DATAPATH"

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

