terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "vishnutstate80203"  # Must match what you created
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate" # The name of the state file it will create
  }
}
