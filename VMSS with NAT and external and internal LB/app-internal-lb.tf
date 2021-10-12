# Resource-1: create an internal LB
resource "azurerm_lb" "app-lb" {
  name = "${local.resource_name_prefix}-app-lb"
  location = azurerm_resource_group.myRG.location
  resource_group_name = azurerm_resource_group.myRG.name
  sku = "Standard"
  frontend_ip_configuration {
    name = "app-lb-frontendip"
    subnet_id = azurerm_subnet.appsubnet.id 
    private_ip_address_allocation = "Static"
    private_ip_address_version = "IPv4"
    private_ip_address = "10.1.11.241"
  }

}

# Resource-2: Create LB Backend pool

resource "azurerm_lb_backend_address_pool" "app-lb-backend" {
    name = "app-backend"
    loadbalancer_id = azurerm_lb.app-lb.id  
}

# Resource-3: Create LB Probe

resource "azurerm_lb_probe" "app-lb-probe" {

    name = "tcp-probe"
    loadbalancer_id = azurerm_lb.web_lb.id
    resource_group_name = azurerm_resource_group.myRG.name
    protocol = "Tcp"
    port = 80  
}

# Resource-4: Create LB Rule

resource "azurerm_lb_rule" "app-lb-rule-app1" {
  name = "app-app1-rule"
  loadbalancer_id = azurerm_lb.web_lb.id
  resource_group_name = azurerm_resource_group.myRG.name
  frontend_port = 80
  backend_port = 80
  protocol = "Tcp"
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.app-lb-backend.id
  probe_id = azurerm_lb_probe.app-lb-probe.id
}
