#  Create RG in East US
resource "azurerm_resource_group" "rg1" {
    name = "eastus-rg1"
    location = "East US"
    provider = azurerm.provider-EASTUS
  }

# Create RG in WEST US

resource "azurerm_resource_group" "rg2" {
    name = "westus-rg2"
    location = "West US"
    provider = azurerm.provider-WESTUS
}