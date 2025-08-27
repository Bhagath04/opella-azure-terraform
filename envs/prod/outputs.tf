output "vnet_name" { value = module.vnet.vnet_name }
output "subnets"   { value = module.vnet.subnet_names }
output "vm_private_ips" { value = azurerm_network_interface.vm.private_ip_address }
output "storage_account_name" { value = azurerm_storage_account.sa.name }
