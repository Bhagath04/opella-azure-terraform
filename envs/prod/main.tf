locals {
  name_prefix = lower(join("-", [var.project, var.environment, replace(var.location, " ", "")]))
  tags = {
    project     = var.project
    environment = var.environment
    region      = var.location
    owner       = "platform@opella"
    managed_by  = "terraform"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.tags
}

module "vnet" {
  source              = "../../modules/vnet"
  name                = "${local.name_prefix}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = var.address_space
  subnets             = var.subnets
  nsg_rules = [
    {
      name                       = "allow-internal-https"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    }
  ]
  tags = local.tags
}

# NIC without public IP for prod (private only)
resource "azurerm_network_interface" "vm" {
  name                = "${local.name_prefix}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipcfg"
    subnet_id                     = module.vnet.subnet_ids["app"]
    private_ip_address_allocation = "Dynamic"

  }
  tags = local.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${local.name_prefix}-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = "Standard_B2s"
  admin_username      = var.vm_admin_username
  network_interface_ids = [azurerm_network_interface.vm.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = var.vm_admin_ssh_key
  }

  disable_password_authentication = true
  tags = local.tags
}

resource "random_string" "sa" {
  length  = 6
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_storage_account" "sa" {
  name                     = replace(substr(join("", ["sap", random_string.sa.result, local.name_prefix]), 0, 24), "-", "")
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_nested_items_to_be_public = false
  min_tls_version          = "TLS1_2"
  tags                     = local.tags
}

resource "azurerm_storage_container" "blobs" {
  name                  = "prod-data"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
