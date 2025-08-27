output "subnet_ids" {
  description = "IDs of created subnets"
  value       = { for k, s in azurerm_subnet.this : k => s.id }
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "nsg_id" {
  description = "ID of the network security group"
  value       = azurerm_network_security_group.this.id
}
