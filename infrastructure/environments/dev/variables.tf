variable "workload" {
  description = "Short workload identifier."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either dev or prod."
  }
}

variable "location" {
  description = "Primary Azure deployment region."
  type        = string
}

variable "location_short" {
  description = "Short Azure region identifier used in resource naming."
  type        = string
}

variable "owner" {
  description = "Team responsible for the workload."
  type        = string
}

variable "cost_center" {
  description = "Cost allocation identifier."
  type        = string
}
