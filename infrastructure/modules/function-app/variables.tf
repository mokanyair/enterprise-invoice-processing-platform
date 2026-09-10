variable "function_app_name" {
  description = "Azure Function App name."
  type        = string
}

variable "service_plan_name" {
  description = "Azure App Service plan name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group containing the Function App."
  type        = string
}

variable "location" {
  description = "Azure deployment region."
  type        = string
}

variable "storage_account_name" {
  description = "Storage Account used by the Function runtime."
  type        = string
}

variable "storage_account_access_key" {
  description = "Storage Account access key used by the Function runtime."
  type        = string
  sensitive   = true
}

variable "invoice_storage_connection_string" {
  description = "Storage connection used by Blob trigger and Blob output bindings."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags applied to Function resources."
  type        = map(string)
  default     = {}
}

variable "raw_container_name" {
  description = "Blob container that receives raw invoices."
  type        = string
  default     = "raw"
}

variable "processed_container_name" {
  description = "Blob container that stores processed invoices."
  type        = string
  default     = "processed"
}
