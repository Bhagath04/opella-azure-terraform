terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  name_prefix = "myproject"
  tags = {
    environment = "dev"
    project     = "terraform-vnet"
  }
}

resource "azurerm_network_security_rule" "this" {
  for_each = var.nsg_rules

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  vnet_name     = "${local.name_prefix}-vnet"
  address_space = ["10.0.0.0/16"]

  subnets = {
    subnet1 = {
      address_prefix = "10.0.1.0/24"
    }
    subnet2 = {
      address_prefix = "10.0.2.0/24"
    }
  }

  nsg_rules = {
    allow_ssh = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  tags = local.tags
}
