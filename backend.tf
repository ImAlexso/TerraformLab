terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-cantera-we"
    storage_account_name = "stterraformcanterawe01"
    container_name       = "tfstate"
    key                  = "terraform_alejandro.tfstate"
  }
}
