variable "system_topic_name" {
  description = "Name of the Event Grid system topic."
  type        = string
}

variable "event_subscription_name" {
  description = "Name of the Event Grid event subscription."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Storage Account and Event Grid resources."
  type        = string
}

variable "location" {
  description = "Azure region of the Event Grid system topic."
  type        = string
}

variable "storage_account_id" {
  description = "Resource ID of the Storage Account producing events."
  type        = string
}

variable "function_app_id" {
  description = "Resource ID of the destination Azure Function App."
  type        = string
}

variable "function_name" {
  description = "Name of the Azure Function receiving Event Grid events."
  type        = string
}

variable "raw_container_name" {
  description = "Blob container whose BlobCreated events should trigger processing."
  type        = string
  default     = "raw"
}

variable "tags" {
  description = "Tags applied to Event Grid resources."
  type        = map(string)
  default     = {}
}
