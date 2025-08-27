project      = "opella"
environment  = "prod"
location     = "westeurope"
address_space= ["10.20.0.0/16"]
subnets = {
  app = {
    address_prefixes = ["10.20.1.0/24"]
    nsg_enabled      = true
  }
  data = {
    address_prefixes = ["10.20.2.0/24"]
    nsg_enabled      = false
  }
}
vm_admin_username = "azureuser"
vm_admin_ssh_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
