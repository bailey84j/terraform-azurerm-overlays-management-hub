# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Terraform Module to deploy the Network Watcher and Flog Logs for Hub Network based on the Azure Mission Landing Zone conceptual architecture
DESCRIPTION: The following components will be options in this deployment              
              * Network Watcher         
AUTHOR/S: jspinella
*/

#-------------------------------------
# Network Watcher - Default is "true"
#-------------------------------------
resource "azurerm_resource_group" "nwatcher" {
  count    = var.create_network_watcher != false ? 1 : 0
  name     = "NetworkWatcherRG"
  location = local.location
  tags     = merge({ "ResourceName" = "NetworkWatcherRG" }, local.default_tags, var.add_tags, )
}

resource "azurerm_network_watcher" "nwatcher" {
  count               = var.create_network_watcher != false ? 1 : 0
  name                = "NetworkWatcher_${var.location}"
  location            = local.location
  resource_group_name = azurerm_resource_group.nwatcher.0.name
  tags                = merge({ "ResourceName" = format("%s", "NetworkWatcher_${var.location}") }, local.default_tags, var.add_tags, )
}

#-----------------------------------------
# Network flow logs for subnet and NSG
#-----------------------------------------
resource "azurerm_network_watcher_flow_log" "nwflog" {
  count                     = var.create_network_watcher != false ? 1 : 0
  name                      = lower("${azurerm_network_watcher.nwatcher.name}-flow-log")
  network_watcher_name      = azurerm_network_watcher.nwatcher.name
  resource_group_name       = azurerm_resource_group.nwatcher.name # Must provide Netwatcher resource Group
  network_security_group_id = azurerm_network_security_group.nsg.id
  storage_account_id        = azurerm_storage_account.storeacc.id
  enabled                   = true
  version                   = 2
  retention_policy {
    enabled = true
    days    = 0
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = data.azurerm_log_analytics_workspace.logws.workspace_id
    workspace_region      = local.location
    workspace_resource_id = data.azurerm_log_analytics_workspace.logws.id
    interval_in_minutes   = 10
  }
}