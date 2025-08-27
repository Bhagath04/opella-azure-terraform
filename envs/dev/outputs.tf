output "vnet_name" { value = module.vnet.vnet_name }
output "subnets"   { value = module.vnet.subnet_names }
output "vm_public_ip" { value = azurerm_public_ip.vm.ip_address }
output "storage_account_name" { value = azurerm_storage_account.sa.name }
