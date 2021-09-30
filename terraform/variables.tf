variable "project" {
  default     = "roi-takeoff-user17"
  description = "GCP Project ID"
}

variable "region" {
  default = "europe-west3"
}

variable "gcp_service_list" {
  description = "The list of apis necessary for the project"
  type        = list(string)
  default = [
    "iam.googleapis.com",
    "cloudbuild.googleapis.com",
    "run.googleapis.com",
  ]
}

variable "app_version" {
  description = "The app version"
  type        = string
  default     = "latest"
}