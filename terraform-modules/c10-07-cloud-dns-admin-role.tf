# gcloud projects add-iam-policy-binding kdaida123 \
#     --member "serviceAccount:wid-gcpiam-sa@kdaida123.iam.gserviceaccount.com" \
#     --role "roles/dns.admin" 



resource "google_project_iam_binding" "dns" {
  project = var.project_id
  role = "roles/dns.admin"
  members = [ 
    "serviceAccount:${google_service_account.service_account.email}"
   ]
}