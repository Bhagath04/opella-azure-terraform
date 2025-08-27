output "vnet_name" {
  description = "The name of the Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "subnet_names" {
  description = "The names of the subnets"
  value       = { for k, s in azurerm_subnet.this : k => s.name }
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = { for k, s in azurerm_subnet.this : k => s.id }
}
