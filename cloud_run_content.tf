resource "google_cloud_run_service_iam_policy" "content-access" {
  service = google_cloud_run_service.content-service.name
  location = google_cloud_run_service.content-service.location
  policy_data = data.google_iam_policy.content.policy_data
}

data "google_iam_policy" "content" {
  binding {
    role = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service" "content-service" {
  name     = "content-service-${var.env_name}"
  location = var.region
  autogenerate_revision_name = true

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "1000"
        "run.googleapis.com/client-name"        = "terraform"
      }
    }
    spec {
      containers {
        image = "gcr.io/${var.shared_vpc_project_id}/content-microservice:${var.content_service_image_tag}"
        resources {
            limits = {
            memory = "1024Mi"
            cpu    = "1000m"
          }
        }
        env {
            name = "url"
            value = "aafes"
        }
      }
    }
  }
}

output "content_service_url" {
  value = google_cloud_run_service.content-service.status[0].url
}

