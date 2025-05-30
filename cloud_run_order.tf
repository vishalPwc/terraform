resource "google_cloud_run_service_iam_policy" "order-access" {
  service     = google_cloud_run_service.order-service.name
  location    = google_cloud_run_service.order-service.location
  policy_data = data.google_iam_policy.order.policy_data
}

data "google_iam_policy" "order" {
  binding {
    role    = "roles/run.invoker"
    members = ["allAuthenticatedUsers"]
  }
}

resource "google_cloud_run_service" "order-service" {
  name                       = "order-service-${var.env_name}"
  location                   = var.region
  autogenerate_revision_name = true

  template {
    metadata {
      annotations = {
        "run.googleapis.com/client-name"   = "terraform"
        "autoscaling.knative.dev/maxScale" = 2
        "autoscaling.knative.dev/minScale" = 1
        "run.googleapis.com/vpc-access-connector" = "${var.shared_vpc_connector}"
        "run.googleapis.com/vpc-access-egress"    = "all-traffic"
      }
    }
    spec {
      containers {
        image = "gcr.io/${var.shared_vpc_project_id}/gcp-docker-registry/order-microservice:${var.order_service_image_tag}"
        resources {
          limits = {
            memory = "1024Mi"
            cpu    = "1000m"
          }
        }

        env {
          name  = "url"
          value = "vmware-k8s-aafes-dev"
        }
        env {
          name  = "mao.env.domain.url"
          value = "https://aafes3.omni.manh.com"
        }
        env {
          name  = "mao.orderlist.endpoint"
          value = "/searchv2/api/searchv2/order"
        }
        env {
          name  = "mao.auth.endpoint"
          value = "https://aafes3-auth.omni.manh.com/oauth/token"
        }
        env {
          name  = "aafes.env.domain.url"
          value = "${var.order_service_env_aafes-env-domain-url}"
        }
        env {
          name  = "mao.client.id"
          value = "omnicomponent.1.0.0"
        }
        env {
          name  = "mao.client.secret"
          value = "b4s8rgTyg55XYNun"
        }
        env {
          name  = "mao.password"
          value = "Exchange1!"
        }
        env {
          name  = "mao.username"
          value = "atg"
        }
        env {
          name  = "mao.grant_type"
          value = "password"
        }
        env {
          name  = "mao.testMode"
          value = "false"
        }
        env {
          name  = "mao.claims.email.endpoint"
          value = "/customerinteraction/api/customerinteraction/email/save"
        }
        env {
          name  = "mao.claims.case.update.endpoint"
          value = "/cases/api/cases/cases/save"
        }
        env {
          name  = "mao.cancel.order.endpoint"
          value = "/order/api/order/order/save"
        }     
        env {
          name  = "logging.level.com.aafes.*"
          value = "DEBUG"
        }     
       env {
          name  = "mao.env.organization"
          value = "ExchangeEcom"
        }                       
      }
    }
  }
}

output "order_service_url" {
  value = google_cloud_run_service.order-service.status[0].url
}
