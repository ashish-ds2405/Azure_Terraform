resource "azurerm_public_ip" "azure_public_ip" {
  name = "${local.resource_name_prefix}-web-linuxvm-publicip"
  allocation_method = "Static"
  resource_group_name = azurerm_resource_group.myRG.name
  location = azurerm_resource_group.myRG.location
  sku = "Standard"
  domain_name_label = "app1-vm-${random_string.myrandom.id}"
}