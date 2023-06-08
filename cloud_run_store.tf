resource "google_cloud_run_service_iam_policy" "store-access" {
  service     = google_cloud_run_service.store-service.name
  location    = google_cloud_run_service.store-service.location
  policy_data = data.google_iam_policy.store.policy_data
}

data "google_iam_policy" "store" {
  binding {
    role = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service" "store-service" {
  name                       = "store-service-${var.env_name}"
  location                   = var.region
  autogenerate_revision_name = true

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "1000"
        "run.googleapis.com/client-name"   = "terraform"
      }
    }
    spec {
      containers {
        image = "gcr.io/${var.shared_vpc_project_id}/store-microservice:${var.store_service_image_tag}"
        resources {
          limits = {
            memory = "1024Mi"
            cpu    = "1000m"
          }
        }
        env {
          name  = "search.endpoint"
          value = "/api/v2/search"
        }
        env {
          name  = "hostname.url.test"
          value = "https://y9vq4.mocklab.io/"
        }
        env {
          name  = "hostname.url"
          value = "https://groupby."
        }
        env {
          name  = "testMode"
          value = "false"
        }
        env {
          name  = "storeRestAPIUrl"
          value = "https://hawk-api.ecomint.aafes.com/public/v1/storeSearch/getNearByStores"
        }
        env {
          name  = "springdoc.swagger-ui.disable-swagger-default-url"
          value = "true"
        }
        env {
          name  = "springdoc.swagger-ui.path"
          value = "/swagger"
        }
        env {
          name  = "server.servlet.context-path"
          value = "/store"
        }     
      }
    }
  }
}

output "store_service_url" {
  value = google_cloud_run_service.store-service.status[0].url
}
