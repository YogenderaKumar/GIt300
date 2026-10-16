terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
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

resource "azurerm_resource_group" "main" {
  name     = "Yogi_Terform"
  location = "West US 3"
}

resource "azurerm_service_plan" "webapp" {
  name                = "yogiwebapp-plan"
  location            = "West US 3"
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "main" {
  name                = "yogiwebapp"
  location            = "West US 3"
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.webapp.id

  site_config {}
}
