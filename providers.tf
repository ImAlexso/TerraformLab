terraform {
  # Versión mínima de Terraform requerida
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
      #In the documentation they specify version 4.1.0, but instead of pinning to a fixed version it's better to use ~> 4.0 so the provider can receive compatible updates without locking it to a single version.
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}