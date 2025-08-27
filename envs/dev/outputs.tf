output "vnet_name" {
  value = module.vnet.vnet_name
}

output "subnets" {
  value = module.vnet.subnet_names
}
