/*
Set envvar before running tf init/plan/apply
Project automation: create source-sa + key + download key in this directory + Enable IAM Service Account Credentials API
Project resource: create impersonated-sa + grant source-sa Token Creator Role
For tf-source-service-account auth, 2 options
    # path to sa key in provider block -> credentials = file("tf-source-service-account.json")
    # env variables: export GOOGLE_CLOUD_KEYFILE_JSON=tf-source-service-account.json
*/


provider "google" {
  credentials = file("tf-source-service-account.json")
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_service_account_access_token" "default" {
  provider               = google
  target_service_account = "tf-impersonated-service-accoun@main-project-lklv.iam.gserviceaccount.com"
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "300s"
}

provider "google" {
  alias        = "impersonated"
  project      = "main-project-lklv"
  access_token = data.google_service_account_access_token.default.access_token
}

data "google_client_openid_userinfo" "me" {}

data "google_client_openid_userinfo" "thenewme" {
  provider = google.impersonated
}

#Outputs
output "source-email" {
  value = data.google_client_openid_userinfo.me.email
}

output "target-email" {
  value = data.google_client_openid_userinfo.thenewme.email
}

resource "google_storage_bucket" "auto-expire" {
  name          = "test-tf-sa-impersonated-storage-admin"
  location      = "US"
  force_destroy = true
  provider      = google.impersonated
}