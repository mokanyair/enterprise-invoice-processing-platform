variable "name" {
  description = "Globally unique Azure Storage Account name."
  type        = string

  validation {
    condition = (
      length(var.name) >= 3 &&
      length(var.name) <= 24 &&
      can(regex("^[a-z0-9]+$", var.name))
    )

    error_message = "Storage account name must contain 3-24 lowercase letters and numbers only."
  }
}

variable "resource_group_name" {
  description = "Resource Group containing the storage account."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "containers" {
  description = "Blob containers created in the storage account."
  type        = set(string)
}

variable "tags" {
  description = "Tags applied to the storage account."
  type        = map(string)
  default     = {}
}

variable "blob_soft_delete_days" {
  description = "Number of days deleted blobs are retained."
  type        = number
  default     = 7
}

variable "container_soft_delete_days" {
  description = "Number of days deleted containers are retained."
  type        = number
  default     = 7
}
