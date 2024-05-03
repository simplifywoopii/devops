resource "google_artifact_registry_repository" "simplifywoopii_repo" {
  depends_on    = [helm_release.argocd]
  location      = var.region
  repository_id = "simplifywoopii-apps"
  description   = "simplifywoopii-apps"
  format        = "DOCKER"
}
