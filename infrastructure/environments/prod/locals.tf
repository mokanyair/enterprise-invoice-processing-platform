locals {
  common_tags = {
    workload    = var.workload
    environment = var.environment
    managed_by  = "terraform"
    owner       = var.owner
    cost_center = var.cost_center
    repository  = "enterprise-invoice-processing-platform"
  }

  resource_groups = {
    application = {
      name = "rg-${var.workload}-${var.environment}-app-${var.location_short}"
    }

    observability = {
      name = "rg-${var.workload}-${var.environment}-obs-${var.location_short}"
    }
  }
  invoice_containers = [
    "raw",
    "processed"
  ]
}
