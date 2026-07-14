# Existing Resource Group
resource "azurerm_resource_group" "jenkins_rg" {
  name     = "myJenkinsResourceGroup"
  location = "eastus"
}

# New Virtual Network
resource "azurerm_virtual_network" "jenkins_vnet" {
  name                = "jenkins-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.jenkins_rg.location
  resource_group_name = azurerm_resource_group.jenkins_rg.name
}

# New Storage Account
resource "azurerm_storage_account" "jenkins_storage" {
  # MUST BE GLOBALLY UNIQUE. Change "vishnujenkinsstore80203" if it fails.
  name                     = "vishnujenkinsstore80203" 
  resource_group_name      = azurerm_resource_group.jenkins_rg.name
  location                 = azurerm_resource_group.jenkins_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
