resource "azurerm_network_interface" "linux-web-nic" {
  name = "${local.resource_name_prefix}-web-linux-nic"
  location = azurerm_resource_group.myRG.location
  resource_group_name = azurerm_resource_group.myRG.name

  ip_configuration {
    name = "web-linux-ip1"
    subnet_id = azurerm_subnet.web-subnet.id 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.azure_public_ip.id 
  }
}