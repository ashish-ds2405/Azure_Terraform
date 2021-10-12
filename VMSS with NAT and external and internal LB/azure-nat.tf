# Resource-1 Create a public IP for NAT

resource "azurerm_public_ip" "nat_public_ip" {
  name = "${local.resource_name_prefix}-natgw-ip"
  location = azurerm_resource_group.myRG.location
  resource_group_name = azurerm_resource_group.myRG.name
  allocation_method = "Static"
  sku = "Standard"
}

# Create NAT gateway

resource "azurerm_nat_gateway" "natgw" {
  name = "${local.resource_name_prefix}-natgw"
  location = azurerm_resource_group.myRG.location
  resource_group_name = azurerm_resource_group.myRG.name
  sku_name = "Standard"
}

# Associate NAT Gateway with public IP

resource "azurerm_nat_gateway_public_ip_association" "nat-pubip-association" {
  nat_gateway_id = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.nat_public_ip.id

}

# Associate NAT Gateway with App subnet

resource "azurerm_subnet_nat_gateway_association" "web-subet-nat-association" {
  nat_gateway_id = azurerm_nat_gateway.natgw.id
  subnet_id = azurerm_subnet.appsubnet.id
  
}