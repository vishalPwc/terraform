resource "google_cloud_run_service_iam_policy" "profile-access" {
  service     = google_cloud_run_service.profile-service.name
  location    = google_cloud_run_service.profile-service.location
  policy_data = data.google_iam_policy.profile.policy_data
}

data "google_iam_policy" "profile" {
  binding {
    role    = "roles/run.invoker"
    members = ["allAuthenticatedUsers"]
  }
}

resource "google_cloud_run_service" "profile-service" {
  name                       = "profile-service-${var.env_name}"
  location                   = var.region
  autogenerate_revision_name = true

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "1000"
        "run.googleapis.com/client-name"   = "terraform"
        "run.googleapis.com/vpc-access-connector" = "${var.shared_vpc_connector}"
        "run.googleapis.com/vpc-access-egress"    = "all-traffic"

      }
    }
    spec {
      containers {
        image = "gcr.io/${var.shared_vpc_project_id}/gcp-docker-registry/profile-microservice:${var.profile_service_image_tag}"
        resources {
          limits = {
            memory = "1024Mi"
            cpu    = "1000m"
          }
        }
        env {
          name  = "foo"
          value = "bar"
        }
      }
    }
  }
}

output "profile_service_url" {
  value = google_cloud_run_service.profile-service.status[0].url
}
