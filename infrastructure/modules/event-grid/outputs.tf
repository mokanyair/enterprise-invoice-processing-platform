output "system_topic_id" {
  description = "Event Grid system topic resource ID."
  value       = azurerm_eventgrid_system_topic.this.id
}

output "system_topic_name" {
  description = "Event Grid system topic name."
  value       = azurerm_eventgrid_system_topic.this.name
}

output "event_subscription_id" {
  description = "Event Grid event subscription resource ID."
  value       = azurerm_eventgrid_system_topic_event_subscription.this.id
}

output "event_subscription_name" {
  description = "Event Grid event subscription name."
  value       = azurerm_eventgrid_system_topic_event_subscription.this.name
}
