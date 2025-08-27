project      = "opella"
environment  = "dev"
location     = "eastus"
address_space= ["10.10.0.0/16"]
subnets = {
  app = {
    address_prefixes = ["10.10.1.0/24"]
    nsg_enabled      = true
  }
  data = {
    address_prefixes = ["10.10.2.0/24"]
    nsg_enabled      = false
  }
}
vm_admin_username = "azureuser"
# paste your ~/.ssh/id_rsa.pub or similar
vm_admin_ssh_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
