variable "api_gw_spec_title" {
  type        = string
  default     = "API GW TITLE"
  description = "title in the spec file for api gateway config"
}

variable "project" {
  type        = string
  default     = "gcppoc-377017"
  description = "Google Cloud Platform Project ID (historically ecom-np-qa-385017)"
}

variable "region" {
  default = "us-central1"
  type    = string
}

variable "env_name" {
  type        = string
  default     = "sjrl-env"
  description = "Environment Name"
}

variable "shared_vpc_project_id" {
  type        = string
  default     = "gcppoc-377017/gcp-docker-registry"
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

variable "service_mobile_sa" {
  type        = string
  default     = ""
  description = "Service Account E-mail for mobile"
}