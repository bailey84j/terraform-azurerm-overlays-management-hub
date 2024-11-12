locals {
  tags = {
    Module  = "overlays-management-hub"
    Toolkit = "Terraform"
    Example = "Management Hub with force tunneling and Encrypted Transport"
  }
}


# Configure the connectivity resources settings.
locals {
    settings = {
      vwan_hub_networks = [
        {
          enabled = true
          config = {
            address_prefix = "10.216.128.0/23"
            location       = "eastus"
            sku            = ""
            routes         = []
            expressroute_gateway = {
              enabled = true
              config = {
                scale_unit = 1
                allow_non_virtual_wan_traffic = false
              }
            }
            vpn_gateway = {
              enabled = false
              config = {
                bgp_settings       = []
                routing_preference = ""
                scale_unit         = 1
              }
            }
            spoke_virtual_network_resource_ids        = []
            secure_spoke_virtual_network_resource_ids = []
            enable_virtual_hub_connections            = false
          }
        },
        {
          enabled = true
          config = {
            address_prefix = "10.216.130.0/23"
            location       = "centralus"
            sku            = ""
            routes         = []
            expressroute_gateway = {
              enabled = false
              config = {
                scale_unit = 1
              }
            }
            vpn_gateway = {
              enabled = true
              config = {
                bgp_settings       = []
                routing_preference = ""
                scale_unit         = 1
              }
            }
            spoke_virtual_network_resource_ids        = []
            secure_spoke_virtual_network_resource_ids = []
            enable_virtual_hub_connections            = false
          }
        },
      ]
    }
}