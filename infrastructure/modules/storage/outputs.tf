output "id" {
  description = "Storage Account resource ID."
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Storage Account name."
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob service endpoint."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "container_names" {
  description = "Blob containers created by the module."
  value       = sort(tolist(var.containers))
}

output "primary_access_key" {
  description = "Primary Storage Account access key."
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "Primary Storage Account connection string."
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
}

