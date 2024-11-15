# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  resource_group_name          = element(coalescelist(data.azurerm_resource_group.rgrp[*].name, module.mod_scaffold_rg[*].resource_group_name, [""]), 0)
  location                     = element(coalescelist(data.azurerm_resource_group.rgrp[*].location, module.mod_scaffold_rg[*].resource_group_location, [""]), 0)
  hub_vnet_name                = coalesce(var.hub_vnet_custom_name, data.azurenoopsutils_resource_name.vnet.result)
  hub_vwan_name                = coalesce(var.hub_vwan_custom_name, data.azurenoopsutils_resource_name.vwan.result)
  #hub_vhub_name                = coalesce(var.hub_vwan_custom_name, data.azurenoopsutils_resource_name.vhub.result)
  hub_firewall_name            = coalesce(var.hub_firewall_custom_name, data.azurenoopsutils_resource_name.firewall.result)
  hub_firewall_policy_name     = coalesce(var.hub_firewall_policy_custom_name, data.azurenoopsutils_resource_name.firewall_policy.result)
  hub_firewall_client_pip_name = coalesce(var.hub_firewall_client_pip_custom_name, data.azurenoopsutils_resource_name.firewall_client_pub_ip.result)
  hub_firewall_mgt_pip_name    = coalesce(var.hub_firewall_mgt_pip_custom_name, data.azurenoopsutils_resource_name.firewall_mgt_pub_ip.result)
  hub_rt_name                  = coalesce(var.hub_routetable_custom_name, data.azurenoopsutils_resource_name.rt.result)
  hub_afw_rt_name              = coalesce(var.hub_routetable_custom_name, data.azurenoopsutils_resource_name.afw_rt.result)
  hub_sa_name                  = coalesce(var.hub_sa_custom_name, data.azurenoopsutils_resource_name.st.result)

  # DDOS Protection Plan
  ddos_plan_name = coalesce(var.ddos_plan_custom_name, data.azurenoopsutils_resource_name.ddos.result)

  # Bastion Host
  bastion_name     = coalesce(var.bastion_custom_name, data.azurenoopsutils_resource_name.bastion.result)
  bastion_pip_name = coalesce(var.bastion_pip_custom_name, data.azurenoopsutils_resource_name.bastion_pip.result)

  # Private Endpoint
  pe_name = data.azurenoopsutils_resource_name.pe.result
  psc_name = data.azurenoopsutils_resource_name.psc.result
  nic_name = data.azurenoopsutils_resource_name.nic.result
}
