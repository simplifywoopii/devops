provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file("../credentials.json")
}
