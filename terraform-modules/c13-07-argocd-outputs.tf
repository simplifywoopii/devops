# Helm Release Outputs
output "argocd_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.argocd.metadata
}
