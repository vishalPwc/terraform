resource "google_cloud_run_service_iam_policy" "akamai-access" {
  service     = google_cloud_run_service.akamai-service.name
  location    = google_cloud_run_service.akamai-service.location
  policy_data = data.google_iam_policy.akamai.policy_data
}

data "google_iam_policy" "akamai" {
  binding {
    role    = "roles/run.invoker"
    members = ["allAuthenticatedUsers"]
  }
}

resource "google_cloud_run_service" "akamai-service" {
  name                       = "akamai-service-${var.env_name}"
  location                   = var.region
  autogenerate_revision_name = true

  template {
    metadata {
      annotations = {
        "run.googleapis.com/client-name"   = "terraform"
        "autoscaling.knative.dev/maxScale" = 2
        "autoscaling.knative.dev/minScale" = 1
      }
    }
    spec {
      containers {
        image = "gcr.io/${var.shared_vpc_project_id}/gcp-docker-registry/nginx:${var.akamai_service_image_tag}"
        resources {
          limits = {
            memory = "1024Mi"
            cpu    = "1000m"
          }
        }
      }
    }
  }
}
