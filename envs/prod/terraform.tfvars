project      = "opella"
environment  = "prod"
location     = "westeurope"
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
