terraform {
  required_version = "=0.12.24"
}

provider "azurerm" {
  version = "~> 2.5"
  features {}
}

resource "azurerm_resource_group" "lab" {
  name     = local.resource_group_name
  location = local.resource_group_location
}

