
resource "google_api_gateway_api" "api_gw" {
  display_name = "ecom-${var.env_name}-apigw"
  provider     = google-beta
  api_id       = "ecom-${var.env_name}-apigw"
  project      = var.project
}

resource "google_api_gateway_gateway" "api_gw" {
  provider     = google-beta
  api_config   = google_api_gateway_api_config.api_gw.id
  gateway_id   = "ecom-${var.env_name}-gw"
  display_name = "ecom-${var.env_name}-gw"
  region       = var.region
  project      = var.project
}

resource "google_api_gateway_api_config" "api_gw" {
  provider      = google-beta
  api           = google_api_gateway_api.api_gw.api_id
  #api_config_id = "my-config"
  project       = var.project

  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = base64encode(data.template_file.swagger.rendered)
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "swagger" {
  template = file("${path.module}/templates/spec.yaml.tpl")

  vars = {
    # Service URLS:
    search_service_url = google_cloud_run_service.search-service.status[0].url
    profile_service_url = google_cloud_run_service.profile-service.status[0].url
    store_service_url = google_cloud_run_service.store-service.status[0].url
    price_service_url = google_cloud_run_service.price-service.status[0].url
    content_service_url = google_cloud_run_service.content-service.status[0].url
    order_service_url = google_cloud_run_service.order-service.status[0].url
    akamai_service_url = google_cloud_run_service.akamai-service.status[0].url
    
    # Service Account Vars:
    service_mao_sa = var.service_mao_sa
    service_atg_sa = var.service_atg_sa
    service_mobile_sa = var.service_mobile_sa
    service_commerce_tools_sa = var.service_commerce_tools_sa

    # Generic:
    api_gw_spec_title = var.api_gw_spec_title
  }
}
