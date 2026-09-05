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
