variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure location for resources"
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "A map of subnets to create"
  type = map(object({
    address_prefix = string
  }))
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "nsg_rules" {
  description = "A map of NSG rules to apply"
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {}
}
