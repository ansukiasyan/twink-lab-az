terraform {
  required_version = "=0.12.24"
}

provider "azurerm" {
  version = "~> 2.5"
  features {}
}

resource "azurerm_resource_group" "prod" {
  name     = local.rsgrp_name
  location = local.rsgrp_location
}

