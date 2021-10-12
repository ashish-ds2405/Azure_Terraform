# Resource-1 Create a private DNS zone

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name = "terraformguru.com"
  resource_group_name = azurerm_resource_group.myRG.name

}

#Resource- 2 Associate Private DNS Zone to Virtual Network

resource "azurerm_private_dns_zone_virtual_network_link" "provate_dns_zone_vnet_association" {
  name = "${local.resource_name_prefix}-pvt-dns-zone-vnet-association"
  resource_group_name = azurerm_resource_group.myRG.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id = azurerm_virtual_network.vnet.id
}

#Resource-3: Internal lb DNS record applb.terraformguru.com

resource "azurerm_private_dns_a_record" "app-lb-dns-a-record" {
  depends_on = [
    azurerm_lb.app-lb
  ]
  name = "applb"
  resource_group_name = azurerm_resource_group.myRG.name
  records = ["${azurerm_lb.app-lb.frontend_ip_configuration[0].private_ip_address}"]
  zone_name = azurerm_private_dns_zone.private_dns_zone.name
  ttl = 300
}