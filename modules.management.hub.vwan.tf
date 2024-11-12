# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: This module will deploy a Hub Virtual Network in Azure.
DESCRIPTION: The following components will be options in this deployment
              * Hub Network Virtual Network
              * Ddos Protection Plan
              * Network Watcher
AUTHOR/S: jrspinella
*/

data "azurerm_subscription" "current" {
}

module "connectivity_resources" {
  source = "./modules/connectivity"

  # Mandatory input variables
  enabled         = local.vwan_enabled
  root_id         = var.org_name
  subscription_id = data.azurerm_subscription.current.subscription_id
  settings        = var.vwan_hub_networks
  deploy_environment = var.deploy_environment

  # Optional input variables (basic configuration)
  location = local.location
  tags     = merge(local.default_tags, var.add_tags, )

}
/*
resource "azurerm_virtual_wan" "virtual_wan" {
  provider = azurerm.connectivity
  count = local.vwan_enabled ? 1 : 0

  # Mandatory resource attributes
  # Resource Group
  
  resource_group_name = local.resource_group_name
  location            = local.location
  name               = local.hub_vwan_name

  # Optional resource attributes
  disable_vpn_encryption            = each.value.template.disable_vpn_encryption
  allow_branch_to_branch_traffic    = each.value.template.allow_branch_to_branch_traffic
  office365_local_breakout_category = each.value.template.office365_local_breakout_category
  type                              = each.value.template.type
  tags = merge({ "ResourceName" = format("%s", local.hub_vwan_name) }, local.default_tags, var.add_tags, )

  # Set explicit dependencies
  depends_on = [
    azurerm_resource_group.connectivity,
    azurerm_resource_group.virtual_wan,
  ]

}


resource "azurerm_virtual_hub" "virtual_wan" {
  #for_each = local.azurerm_virtual_hub_virtual_wan

  provider = azurerm.connectivity

  # Mandatory resource attributes
  name                = each.value.template.name
  resource_group_name = each.value.template.resource_group_name
  location            = each.value.template.location

  # Optional resource attributes
  sku                    = each.value.template.sku
  address_prefix         = each.value.template.address_prefix
  hub_routing_preference = each.value.template.hub_routing_preference
  virtual_wan_id         = each.value.template.virtual_wan_id
  tags = merge({ "ResourceName" = format("%s", local.hub_vwan_name) }, local.default_tags, var.add_tags, )

  # Dynamic configuration blocks
  dynamic "route" {
    for_each = each.value.template.route
    content {
      # Mandatory attributes
      address_prefixes    = route.value["address_prefixes"]
      next_hop_ip_address = route.value["next_hop_ip_address"]
    }
  }

  # Set explicit dependencies
  depends_on = [
    azurerm_resource_group.connectivity,
    azurerm_resource_group.virtual_wan,
    azurerm_virtual_wan.virtual_wan,
  ]

}


*/