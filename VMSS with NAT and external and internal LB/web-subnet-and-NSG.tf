# create a web subnet

resource "azurerm_subnet" "web-subnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  resource_group_name = azurerm_resource_group.myRG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.web_subnet_address

}

# create a NSG

resource "azurerm_network_security_group" "web_subnet_nsg" {
  name = "${azurerm_subnet.web-subnet.name}-nsg"
  location = azurerm_resource_group.myRG.location
  resource_group_name = azurerm_resource_group.myRG.name
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg" {
  depends_on = [ azurerm_network_security_rule.web_nsg_rule_inbound]
  subnet_id = azurerm_subnet.web-subnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}

#Create NSG Rules

locals {
  web_inbound_map_ports = {
      "100" : "80",
      "110" : "443",
      "120" : "22"
  }
}

resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
    for_each = web_inbound_map_ports
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myRG.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}