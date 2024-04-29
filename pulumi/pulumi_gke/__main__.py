import pulumi
import pulumi_gcp as gcp

# Get some provider-namespaced configuration values
provider_cfg = pulumi.Config("gcp")
gcp_project = provider_cfg.require("project")
gcp_region = provider_cfg.get("region", "us-central1")
# Get some additional configuration values
config = pulumi.Config()
nodes_per_zone = config.get_int("nodesPerZone", 1)

# Create a new network
gke_network = gcp.compute.Network(
    "gke-network",
    auto_create_subnetworks=False,
    description="A virtual network for your GKE cluster(s)",
)

# Create a subnet in the new network
gke_subnet = gcp.compute.Subnetwork(
    "gke-subnet",
    ip_cidr_range="10.128.0.0/20",
    network=gke_network.id,
    private_ip_google_access=True,
)

# Create a cluster in the new network and subnet
gke_cluster = gcp.container.Cluster(
    "gke-cluster",
    master_auth=gcp.container.ClusterMasterAuthArgs(
        client_certificate_config=gcp.container.ClusterMasterAuthClientCertificateConfigArgs(
            issue_client_certificate=True,
        ),
    ),
    addons_config=gcp.container.ClusterAddonsConfigArgs(
        dns_cache_config=gcp.container.ClusterAddonsConfigDnsCacheConfigArgs(
            enabled=True
        ),
        gce_persistent_disk_csi_driver_config=gcp.container.ClusterAddonsConfigGcePersistentDiskCsiDriverConfigArgs(
            enabled=True
        ),
        gcp_filestore_csi_driver_config=gcp.container.ClusterAddonsConfigGcpFilestoreCsiDriverConfigArgs(
            enabled=True
        ),
    ),
    binary_authorization=gcp.container.ClusterBinaryAuthorizationArgs(
        evaluation_mode="DISABLED"
    ),
    datapath_provider="ADVANCED_DATAPATH",
    description="A GKE cluster",
    initial_node_count=1,
    location=gcp_region,
    min_master_version="1.29",
    default_max_pods_per_node=110,
    node_locations=[
        "us-central1-a",
        "us-central1-b",
        "us-central1-c",
    ],
    database_encryption=gcp.container.ClusterDatabaseEncryptionArgs(state="DECRYPTED"),
    enable_shielded_nodes=True,
    deletion_protection=False,
    logging_config=gcp.container.ClusterLoggingConfigArgs(
        enable_components=["SYSTEM_COMPONENTS", "WORKLOADS"]
    ),
    monitoring_config=gcp.container.ClusterMonitoringConfigArgs(
        enable_components=["SYSTEM_COMPONENTS"],
        managed_prometheus=gcp.container.ClusterMonitoringConfigManagedPrometheusArgs(
            enabled=True,
        ),
    ),
    security_posture_config=gcp.container.ClusterSecurityPostureConfigArgs(
        mode="BASIC",
        vulnerability_mode="VULNERABILITY_DISABLED",
    ),
    network=gke_network.name,
    networking_mode="VPC_NATIVE",
    private_cluster_config=gcp.container.ClusterPrivateClusterConfigArgs(
        enable_private_nodes=True,
        enable_private_endpoint=False,
        master_global_access_config=gcp.container.ClusterPrivateClusterConfigMasterGlobalAccessConfigArgs(
            enabled=True,
        ),
        master_ipv4_cidr_block="172.16.0.0/28",
    ),
    remove_default_node_pool=True,
    release_channel=gcp.container.ClusterReleaseChannelArgs(channel="RAPID"),
    subnetwork=gke_subnet.name,
    workload_identity_config=gcp.container.ClusterWorkloadIdentityConfigArgs(
        workload_pool=f"{gcp_project}.svc.id.goog"
    ),
)

# Create a GCP service account for the nodepool
gke_nodepool_sa = gcp.serviceaccount.Account(
    "gke-nodepool-sa",
    account_id=pulumi.Output.concat(gke_cluster.name, "-np-1-sa"),
    display_name="Nodepool 1 Service Account",
)

# Create a nodepool for the cluster
gke_nodepool = gcp.container.NodePool(
    "gke-nodepool",
    cluster=gke_cluster.id,
    node_count=nodes_per_zone,
    location="us-central1",
    max_pods_per_node=110,
    upgrade_settings=gcp.container.NodePoolUpgradeSettingsArgs(
        max_surge=1,
        strategy="SURGE",
    ),
    node_config=gcp.container.NodePoolNodeConfigArgs(
        disk_size_gb=20,
        disk_type="pd-balanced",
        labels={
            "owners": "simplifywoopii",
            "environment": "dev",
            "name": "simplifywoopii-dev",
        },
        machine_type="e2-medium",
        metadata={
            "disable-legacy-endpoints": "true",
        },
        oauth_scopes=["https://www.googleapis.com/auth/cloud-platform"],
        service_account="simplifywoopii@devops-421112.iam.gserviceaccount.com",
        shielded_instance_config=gcp.container.NodePoolNodeConfigShieldedInstanceConfigArgs(
            enable_integrity_monitoring=True,
        ),
        spot=True,
        workload_metadata_config=gcp.container.NodePoolNodeConfigWorkloadMetadataConfigArgs(
            mode="GKE_METADATA",
        ),
        tags=["gke-node", "simplifywoopii-dev-gke"],
    ),
)

# Build a Kubeconfig to access the cluster
cluster_kubeconfig = pulumi.Output.all(
    gke_cluster.master_auth.cluster_ca_certificate,
    gke_cluster.endpoint,
    gke_cluster.name,
).apply(
    lambda l: f"""apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: {l[0]}
    server: https://{l[1]}
  name: {l[2]}
contexts:
- context:
    cluster: {l[2]}
    user: {l[2]}
  name: {l[2]}
current-context: {l[2]}
kind: Config
preferences: {{}}
users:
- name: {l[2]}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: gke-gcloud-auth-plugin
      installHint: Install gke-gcloud-auth-plugin for use with kubectl by following
        https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
      provideClusterInfo: true
"""
)

# Export some values for use elsewhere
pulumi.export("networkName", gke_network.name)
pulumi.export("networkId", gke_network.id)
pulumi.export("clusterName", gke_cluster.name)
pulumi.export("clusterId", gke_cluster.id)
pulumi.export("kubeconfig", cluster_kubeconfig)
