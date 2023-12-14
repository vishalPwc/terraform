variable "api_gw_spec_title" {
  type        = string
  default     = "API GW TITLE"
  description = "title in the spec file for api gateway config"
}

variable "project" {
  type        = string
  default     = "ecom-np-dev-385017"
  description = "Google Cloud Platform Project ID (historically ecom-np-qa-385017)"
}

variable "region" {
  default = "us-central1"
  type    = string
}

variable "env_name" {
  type        = string
  default     = "dev"
  description = "Environment Name"
}

variable "shared_vpc_project_id" {
  type        = string
  default     = "ecom-np-vpc-385017"
  description = "Google Cloud Platform Shared VPC Project ID (historically ecom-np-vpc-385017)"
}

variable "store_service_image_tag" {
  type        = string
  default     = "latest"
  description = "Image tag for Cloud Run Store Service"
}

variable "search_service_image_tag" {
  type        = string
  default     = "latest"
  description = "Image tag for Cloud Run Search Service"
}

variable "price_service_image_tag" {
  type        = string
  default     = "latest"
  description = "Image tag for Cloud Run Price Service"
}

variable "order_service_image_tag" {
  type        = string
  default     = "latest"
  description = "Image tag for Cloud Run Order Service"
}

variable "content_service_image_tag" {
  type        = string
  default     = "latest"
  description = "Image tag for Cloud Run Content Service"
}

variable "profile_service_image_tag" {
  type        = string
  default     = "latest"
  description = "Image tag for Cloud Run Profile Service"
}

variable "akamai_service_image_tag" {
  type        = string
  default     = "versionsix"
  description = "Image tag for Cloud Run Akamai Route Service"
}

variable "service_mao_sa" {
  type        = string
  default     = ""
  description = "Service Account E-mail for MAO"
}

variable "service_atg_sa" {
  type        = string
  default     = ""
  description = "Service Account E-mail for ATG"
}

variable "service_commerce_tools_sa" {
  type        = string
  default     = ""
  description = "Service Account E-mail for commerce tools"
}

variable "service_mobile_sa" {
  type        = string
  default     = ""
  description = "Service Account E-mail for mobile"
}

variable "staticContent_asset_contextRoot" {
  type        = string
  default     = "https://www.shopmyexchange.com/cp/"
  description = "Content MS - Env. Var. - Content"
}

variable "shared_vpc_connector" {
  type        = string
  default     = "projects/ecom-np-vpc-385017/locations/us-central1/connectors/ecom-np-shared-connector"
  description = "Shared VPC Access"
}

variable "order_service_env_aafes-env-domain-url" {
  type        = string
  default     = ""
  description = "Order MS - Env. Var - CSCR"
}

variable "store_service_env_storeRestAPIUrl" {
  type        = string
  default     = ""
  description = "Store MS - Env. Var - Rest API URL"
}
