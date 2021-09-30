terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_project_service" "gcp_services" {
  for_each           = toset(var.gcp_service_list)
  project            = var.project
  service            = each.key
  disable_on_destroy = false
}

resource "google_service_account" "service_account" {
  account_id   = "service-account"
  display_name = "SA"
}

resource "google_project_iam_binding" "service_permissions" {
  for_each = toset([
    "run.invoker", "datastore.owner", "storage.objectViewer"
  ])

  role       = "roles/${each.key}"
  members    = ["serviceAccount:${google_service_account.service_account.email}"]
  depends_on = [google_service_account.service_account]
}

resource "google_cloud_run_service" "default" {
  name     = "go-pets"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.service_account.email
      containers {
        image = "gcr.io/roi-takeoff-user17/go-pets:${var.app_version}"
        env {
          name  = "GOOGLE_CLOUD_PROJECT"
          value = var.project
        }
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

output "public_url" {
  value = google_cloud_run_service.default.status[0].url
}
