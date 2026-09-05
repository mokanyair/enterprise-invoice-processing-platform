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
