project      = "opella"
environment  = "sit"
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
variable "vm_admin_ssh_key" {
  type        = string
  description = "Public SSH key for VM admin user"
}
