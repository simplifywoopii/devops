# gcloud projects add-iam-policy-binding kdaida123 \
#     --member "serviceAccount:wid-gcpiam-sa@kdaida123.iam.gserviceaccount.com" \
#     --role "roles/dns.admin" 



# data "google_iam_policy" "dns" {
#   binding {
#     role = "roles/dns.admin"

#     members = [
#       "serviceAccount:${google_service_account.service_account.email}"
#     ]
#   }
# }



# resource "google_service_account_iam_policy" "dns" {
#   service_account_id = google_service_account.service_account.name
#   policy_data        = data.google_iam_policy.dns.policy_data
# }


# resource "google_service_account_iam_binding" "dns" {
#   service_account_id = google_service_account.service_account.name
#   role               = "roles/dns.admin"

#   members = [
#     # "serviceAccount:${google_service_account.service_account.email}",      
#      "serviceAccount:wid-gcpiam-sa@devops-421112.iam.gserviceaccount.com"
#   ]
# }