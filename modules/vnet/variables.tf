terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.100.0"
    }
  }
}

variable "name" {
  description = "Base name for the VNet"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where VNet will be created"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "address_space" {
  description = "CIDR blocks for the VNet"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnet definitions. Key = subnet name"
  type = map(object({
    address_prefixes = list(string)
    nsg_enabled      = optional(bool, false)
  }))
  default = {}
}

variable "nsg_rules" {
  description = "Optional NSG rules to apply when nsg_enabled=true on a subnet"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
