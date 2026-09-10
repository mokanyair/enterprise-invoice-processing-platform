resource "azurerm_eventgrid_system_topic" "this" {
  name                   = var.system_topic_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  source_arm_resource_id = var.storage_account_id
  topic_type             = "Microsoft.Storage.StorageAccounts"

  tags = var.tags
}

resource "azurerm_eventgrid_system_topic_event_subscription" "this" {
  name                = var.event_subscription_name
  resource_group_name = var.resource_group_name
  system_topic        = azurerm_eventgrid_system_topic.this.name

  included_event_types = [
    "Microsoft.Storage.BlobCreated"
  ]

  subject_filter {
    subject_begins_with = "/blobServices/default/containers/${var.raw_container_name}/blobs/"
    case_sensitive      = false
  }

  azure_function_endpoint {
    function_id = "${var.function_app_id}/functions/${var.function_name}"

    max_events_per_batch              = 1
    preferred_batch_size_in_kilobytes = 64
  }
}
