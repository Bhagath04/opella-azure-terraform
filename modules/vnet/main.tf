provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

# Create subnets
resource "azurerm_subnet" "this" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
}

# Optional NSG per subnet
resource "azurerm_network_security_group" "subnet" {
  for_each            = { for k, v in var.subnets : k => v if try(v.nsg_enabled, false) }
  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "subnet_rules" {
  for_each = {
    for s, cfg in var.subnets : s => cfg if try(cfg.nsg_enabled, false)
  }

  count                      = length(var.nsg_rules)
  name                       = var.nsg_rules[count.index].name
  priority                   = var.nsg_rules[count.index].priority
  direction                  = var.nsg_rules[count.index].direction
  access                     = var.nsg_rules[count.index].access
  protocol                   = var.nsg_rules[count.index].protocol
  source_port_range          = var.nsg_rules[count.index].source_port_range
  destination_port_range     = var.nsg_rules[count.index].destination_port_range
  source_address_prefix      = var.nsg_rules[count.index].source_address_prefix
  destination_address_prefix = var.nsg_rules[count.index].destination_address_prefix
  resource_group_name        = var.resource_group_name
  network_security_group_name= azurerm_network_security_group.subnet[each.key].name
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each                  = { for k, v in var.subnets : k => v if try(v.nsg_enabled, false) }
  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.subnet[each.key].id
}
