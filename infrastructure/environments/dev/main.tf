module "resource_groups" {
  source = "../../modules/resource-group"

  for_each = local.resource_groups

  name     = each.value.name
  location = var.location

  tags = merge(
    local.common_tags,
    {
      resource_group_purpose = each.key
    }
  )
}

module "invoice_storage" {
  source = "../../modules/storage"

  name                = var.invoice_storage_account_name
  resource_group_name = module.resource_groups["application"].name
  location            = var.location

  containers = local.invoice_containers

  tags = merge(
    local.common_tags,
    {
      purpose = "invoice-processing"
    }
  )

  depends_on = [
    module.resource_groups
  ]
}

module "invoice_function" {
  source = "../../modules/function-app"

  function_app_name   = var.function_app_name
  service_plan_name   = var.function_service_plan_name
  resource_group_name = module.resource_groups["application"].name
  location            = var.location

  storage_account_name       = module.invoice_storage.name
  storage_account_access_key = module.invoice_storage.primary_access_key

  invoice_storage_connection_string = module.invoice_storage.primary_connection_string

  tags = merge(
    local.common_tags,
    {
      purpose = "invoice-processing-function"
    }
  )
}
