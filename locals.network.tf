# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Configuration settings for resource type:
#  - azurerm_private_dns_zone
locals {
  vnet_enabled = var.vnet_vs_vwan == "vnet" ? true : false
  vwan_enabled = var.vnet_vs_vwan == "vwan" ? true : false
}
