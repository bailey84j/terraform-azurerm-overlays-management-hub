module "mod_azregions" {
  for_each= {for location in local.connectivity_locations : location => location}
  source  = "azurenoops/overlays-azregions-lookup/azurerm"
  version = "1.0.1"

  azure_region = var.location
}

data "azurenoopsutils_resource_name" "connectivity_location_rg" {
  for_each= {for location in local.connectivity_locations : location => location}
  name          = var.workload_name
  resource_type = "azurerm_resource_group"
  prefixes      = [var.root_id, var.use_location_short_name ? module.mod_azregions[each.value].location_short : module.mod_azregions.location_cli]
  suffixes      = compact([var.name_prefix == "" ? null : local.name_prefix, var.deploy_environment, local.name_suffix, var.use_naming ? "" : "rg"])
  use_slug      = var.use_naming
  clean_input   = true
  separator     = "-"
}

data "azurenoopsutils_resource_name" "connectivity_location_vhub" {
  for_each= {for location in local.connectivity_locations : location => location}
  name          = var.workload_name
  resource_type = "azurerm_virtual_hub"
  prefixes      = [var.root_id, var.use_location_short_name ? module.mod_azregions[each.value].location_short : module.mod_azregions.location_cli]
  suffixes      = compact([var.name_prefix == "" ? null : local.name_prefix, var.deploy_environment, local.name_suffix, var.use_naming ? "" : "vhub"])
  use_slug      = var.use_naming
  clean_input   = true
  separator     = "-"
}

data "azurenoopsutils_resource_name" "connectivity_location_ergw" {
  for_each= {for location in local.connectivity_locations : location => location}
  name          = var.workload_name
  resource_type = "azurerm_express_route_gateway"
  prefixes      = [var.root_id, var.use_location_short_name ? module.mod_azregions[each.value].location_short : module.mod_azregions.location_cli]
  suffixes      = compact([var.name_prefix == "" ? null : local.name_prefix, var.deploy_environment, local.name_suffix, var.use_naming ? "" : "ergw"])
  use_slug      = var.use_naming
  clean_input   = true
  separator     = "-"
}

data "azurenoopsutils_resource_name" "connectivity_location_pip" {
  for_each= {for location in local.connectivity_locations : location => location}
  name          = var.workload_name
  resource_type = "azurerm_public_ip"
  prefixes      = [var.root_id, var.use_location_short_name ? module.mod_azregions[each.value].location_short : module.mod_azregions.location_cli]
  suffixes      = compact([var.name_prefix == "" ? null : local.name_prefix, var.deploy_environment, local.name_suffix, var.use_naming ? "" : "pip"])
  use_slug      = var.use_naming
  clean_input   = true
  separator     = "-"
}