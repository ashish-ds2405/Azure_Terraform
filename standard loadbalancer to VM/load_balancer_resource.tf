# create public ip for LB

resource "azurerm_public_ip" "web_lb_publicip" {
  name = "${local.resource_name_prefix}-lbpublicip"
  resource_group_name = azurerm_resource_group.myRG.name
  location = azurerm_resource_group.myRG.location
  allocation_method = "Static"
  sku = "Standard"
  tags = locals.common_tags

}

resource "azurerm_lb" "web_lb" {
    name = "${local.resource_name_prefix}-web-lb"
    resource_group_name = azurerm_resource_group.myRG.name
    location = azurerm_resource_group.myRG.location
    sku = "Standard"
    frontend_ip_configuration {
      name = "web_lb_frontend_ip"
      public_ip_address_id = azurerm_public_ip.web_lb_publicip.id
    }
  
}

#Create a backend pool

resource "azurerm_lb_backend_address_pool" "web_lb_backend_pool" {
  name = "web_backend"
  loadbalancer_id = azurerm_lb.web_lb.id

}

#create a LB probe

resource "azurerm_lb_probe" "web_lb_probe" {
  name = "tcp-probe"
  protocol = "Tcp"
  port = 80
  loadbalancer_id = azurerm_lb.web_lb.id
  resource_group_name = azurerm_resource_group.myRG.name

}

#Create a LB Rule

resource "azurerm_lb_rule" "web_lb_rule" {
  name = "web-app1-rule"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_pool.id
  probe_id = azurerm_lb_probe.web_lb_probe.id
  loadbalancer_id = azurerm_lb.web_lb.id
  resource_group_name = azurerm_resource_group.myRG.name
}

#Associate NIC with LB

resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_associate" {
  network_interface_id = azurerm_network_interface.linux-web-nic.id
  ip_configuration_name = azurerm_network_interface.linux-web-nic.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_pool.id   
}