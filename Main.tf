terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "terformyogistorage"
    container_name       = "tfstate"
    key                  = "github300.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "storage" {
  name     = "yogistorage"
  location = "westus"
}

resource "azurerm_storage_account" "main" {
  name                     = "yogialphastorage321"
  resource_group_name      = azurerm_resource_group.storage.name
  location                 = azurerm_resource_group.storage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"

  allow_nested_items_to_be_public = false
}
