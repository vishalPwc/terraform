resource "google_cloud_run_service_iam_policy" "search-access" {
  service     = google_cloud_run_service.search-service.name
  location    = google_cloud_run_service.search-service.location
  policy_data = data.google_iam_policy.search.policy_data
}

data "google_iam_policy" "search" {
  binding {
    role    = "roles/run.invoker"
    members = ["allAuthenticatedUsers"]
  }
}

resource "google_cloud_run_service" "search-service" {
  name                       = "search-service-${var.env_name}"
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
        image = "gcr.io/${var.shared_vpc_project_id}/gcp-docker-registry/search-microservice:${var.search_service_image_tag}"
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
        env {
          name  = "url"
          value = "gcp-dev"
        }
        env {
          name  = "search.endpoint"
          value = "/api/search"
        }
        env {
          name  = "hostname.url.test"
          value = "https://y9vq4.mocklab.io"
        }
        env {
          name  = "hostname.url"
          value = "https://search.aafes.groupbycloud.com"
        }
        env {
          name  = "autosuggest.hostname.url"
          value = "https://autocomplete.aafes.groupbycloud.com"
        }
        env {
          name  = "search.ub.endpoint"
          value = "/test/ubPr"
        }
        env {
          name  = "groupBy.clientKey"
          value = "7d89414d-d789-4047-82ba-462d5e33a6e6"
        }
        env {
          name  = "groupBy.customerId"
          value = "aafes"
        }
        env {
          name  = "search.page.size"
          value = "36"
        }
        env {
          name  = "facet.range.list"
          value = "attributes.averageCustomerRating,attributes.activePrice"
        }
        env {
          name  = "facet.ratings.max"
          value = "5"
        }        
        env {
          name  = "autosuggest.endpoint"
          value = "/api/request"
        }
        env {
          name  = "search.collection"
          value = "aafesProduction"
        }
        env {
          name  = "search.area"
          value = "Production"
        }
        env {
          name  = "predictive.searchTerms.testMode"
          value = "false"
        }
        env {
          name  = "product.search.testMode"
          value = "false"
        }
        env {
          name  = "predictive.search.redirectPage"
          value = "/browse"
        }
        env {
          name  = "special.char.list"
          value = "&,-,_,/,\\,',"
        }
        env {
          name  = "ub.search.page.size"
          value = "12"
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
          name  = "predictive.products.page.size"
          value = "10"
        }
        env {
          name  = "predictive.search.searchTermsOnly"
          value = "true"
        }
        env {
          name  = "search.prefilter"
          value = "(((attributes.type_new:IN(17,18) OR (attributes.stockStatus:ANY(\"true\"))) OR ((attributes.stockStatus:ANY(\"false\")) AND (attributes.displaySoldOut:ANY(\"true\")))) AND (attributes.siteId:ANY(\"aafesDefaultSite\")))"
        }        
      }
    }
  }
}

output "search_service_url" {
  value = google_cloud_run_service.search-service.status[0].url
}
