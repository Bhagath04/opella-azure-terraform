terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.100.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  backend "local" {}
  # For team use, switch to AzureRM backend and storage account if desired.
}

provider "azurerm" {
  features {}
}
