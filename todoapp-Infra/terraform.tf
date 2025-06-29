terraform {
  required_version = "1.11.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.25.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "0fb3b41d-23bc-47d2-861e-1582e1789bd5"
}