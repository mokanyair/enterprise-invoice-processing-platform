output "resource_groups" {
  description = "Azure Resource Groups provisioned for this environment."

  value = {
    for key, rg in module.resource_groups :
    key => {
      id       = rg.id
      name     = rg.name
      location = rg.location
    }
  }
}

output "invoice_storage" {
  description = "PROD invoice-processing Blob Storage configuration."

  value = {
    id                    = module.invoice_storage.id
    name                  = module.invoice_storage.name
    primary_blob_endpoint = module.invoice_storage.primary_blob_endpoint
    containers            = module.invoice_storage.container_names
  }

}

output "invoice_function" {
  value = {
    id               = module.invoice_function.id
    name             = module.invoice_function.name
    default_hostname = module.invoice_function.default_hostname
    principal_id     = module.invoice_function.principal_id
  }
}
