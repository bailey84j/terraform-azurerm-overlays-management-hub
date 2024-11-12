
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#############################
# Network Configuration    ##
#############################

variable "vnet_vs_vwan" {
  type = string
  description = "Choose between using VWAN or VNet Hub interconnectivity"
  default = "vnet"
  
}

##########################
# VNet Configuration    ##
##########################

variable "virtual_network_address_space" {
  description = "The address space to be used for the Azure virtual network."
  default     = []
}

variable "create_ddos_plan" {
  description = "Create an ddos plan - Default is false"
  default     = false
}

variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics Workspace to be used for Azure Network Watcher"
  default     = null
}

variable "log_analytics_workspace_resource_group_name" {
  description = "The name of the resource group in which the Log Analytics Workspace is located"
  default     = null
}



##########################
# VWAN Configuration    ##
##########################

variable "vwan_hub_networks" {
  type = object({
      vwan_hub_networks = optional(list(
        object({
          enabled = optional(bool, true)
          config = object({
            address_prefix = string
            location       = string
            sku            = optional(string, "")
            routes = optional(list(
              object({
                address_prefixes    = list(string)
                next_hop_ip_address = string
              })
            ), [])
            routing_intent = optional(object({
              enabled = optional(bool, false)
              config = optional(object({
                routing_policies = optional(list(object({
                  name         = string
                  destinations = list(string)
                })), [])
              }), {})
            }), {})
            expressroute_gateway = optional(object({
              enabled = optional(bool, false)
              config = optional(object({
                scale_unit                    = optional(number, 1)
                allow_non_virtual_wan_traffic = optional(bool, false)
              }), {})
            }), {})
            vpn_gateway = optional(object({
              enabled = optional(bool, false)
              config = optional(object({
                bgp_settings = optional(list(
                  object({
                    asn         = number
                    peer_weight = number
                    instance_0_bgp_peering_address = optional(list(
                      object({
                        custom_ips = list(string)
                      })
                    ), [])
                    instance_1_bgp_peering_address = optional(list(
                      object({
                        custom_ips = list(string)
                      })
                    ), [])
                  })
                ), [])
                routing_preference = optional(string, "Microsoft Network")
                scale_unit         = optional(number, 1)
              }), {})
            }), {})
            spoke_virtual_network_resource_ids        = optional(list(string), [])
            secure_spoke_virtual_network_resource_ids = optional(list(string), [])
            enable_virtual_hub_connections            = optional(bool, false)
          })
        })
      ), [])
  })
  default = {
    
  }
}