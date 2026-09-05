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

variable "invoice_storage_account_name" {
  description = "Globally unique Storage Account used for invoice processing."
  type        = string

  validation {
    condition = (
      length(var.invoice_storage_account_name) >= 3 &&
      length(var.invoice_storage_account_name) <= 24 &&
      can(regex("^[a-z0-9]+$", var.invoice_storage_account_name))
    )

    error_message = "Storage account name must contain 3-24 lowercase letters and numbers only."
  }
}

