resource "azurerm_resource_group" "myrg" {
  name = "myrg-eastus"
  location = "East US"
}

resource "random_string" "myrandom" {
  length = 16
  upper = false 
  special = false
}

#create a storage account

resource "azurerm_storage_account" "mystorageaccount" {
  name = "mysa${random_string.myrandom.id}"
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  account_tier = "Standard"
  account_replication_type = "GRS"
  account_encryption_source = "Microsoft.Storage"

  tags = {
    "environment" = "staging"
  }
}