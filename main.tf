locals {
  name_prefix = "myproject"
  tags = {
    environment = "dev"
    project     = "terraform-vnet"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.name_prefix}-rg"
  location = "East US"
  tags     = local.tags
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
