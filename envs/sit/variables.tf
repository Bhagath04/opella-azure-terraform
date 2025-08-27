variable "project" { type = string }
variable "environment" { type = string }
variable "location" { type = string }
variable "address_space" { type = list(string) }

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
    nsg_enabled      = optional(bool, false)
  }))
}

variable "vm_admin_username" { type = string }
variable "vm_admin_ssh_key"  { type = string }
