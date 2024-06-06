# network
output "network_auto_create_subnetworks" {
  value = google_compute_network.network.auto_create_subnetworks
}

output "network_description" {
  value = google_compute_network.network.description
}

output "network_enable_ula_internal_ipv6" {
  value = google_compute_network.network.enable_ula_internal_ipv6
}

output "network_gateway_ipv4" {
  value = google_compute_network.network.gateway_ipv4
}

output "network_id" {
  value = google_compute_network.network.id
}

output "network_internal_ipv6_range" {
  value = google_compute_network.network.internal_ipv6_range
}

output "network_mtu" {
  value = google_compute_network.network.mtu
}

output "network_name" {
  value = google_compute_network.network.name
}

output "network_network_firewall_policy_enforcement_order" {
  value = google_compute_network.network.network_firewall_policy_enforcement_order
}

output "network_numeric_id" {
  value = google_compute_network.network.numeric_id
}

output "network_project" {
  value = google_compute_network.network.project
}

output "network_routing_mode" {
  value = google_compute_network.network.routing_mode
}

output "network_self_link" {
  value = google_compute_network.network.self_link
}

# subnet
output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}