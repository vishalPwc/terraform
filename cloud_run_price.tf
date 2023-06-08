resource "google_cloud_run_service_iam_policy" "price-access" {
  service = google_cloud_run_service.price-service.name
  location = google_cloud_run_service.price-service.location
  policy_data = data.google_iam_policy.price.policy_data
}

data "google_iam_policy" "price" {
  binding {
    role = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service" "price-service" {
  name     = "price-service-${var.env_name}"
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
        image = "gcr.io/${var.shared_vpc_project_id}/price-microservice:${var.price_service_image_tag}"
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
        env {
            name = "hosturl"
            value = "https://goat-cscr.ecomint.aafes.com"
        } 
      }
    }
  }
}

output "price_service_url" {
  value = google_cloud_run_service.price-service.status[0].url
}
