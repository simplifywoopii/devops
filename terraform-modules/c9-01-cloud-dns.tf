# resource "google_dns_managed_zone" "prod" {
#   name     = "simplifywoopii"
#   dns_name = "simplifywoopii.com."
# }


locals {
  simplifywoopii_dns_managed_zone = {
    name = "simplifywoopii" 
    dns_name = "simplifywoopii.com."
  } 
}


resource "google_dns_record_set" "frontend" {
  name = "demo1.${local.simplifywoopii_dns_managed_zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = local.simplifywoopii_dns_managed_zone.name

  rrdatas = [google_compute_global_address.static.address]
}