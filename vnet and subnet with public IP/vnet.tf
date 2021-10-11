# Create a virtual network

resource "azurerm_virtual_network" "vnet1" {
  name = "myVnet-1"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name
  tags = {
    "env" = "demo"
  }
}

# Create a subnet 

resource "azurerm_subnet" "subnet1" {
  name = "subnet1"
  address_prefixes = [ "10.0.0.0/24","10.0.1.0/24" ]
  resource_group_name = azurerm_resource_group.RG1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
}

# Create public ip address

resource "azurerm_public_ip" "mypublicip" {
    name = "publicip-1"
    resource_group_name = azurerm_resource_group.RG1.name
    location = azurerm_resource_group.RG1.location
    allocation_method = "Static"
    tags = {
      "environment" = "demo"
    }
  
}

# Create a network interface

resource "azurerm_network_interface" "nic-1" {
  name = "mynic-1"
  resource_group_name = azurerm_resource_group.RG1.name
  location = azurerm_resource_group.RG1.location
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip.id
  }
}