#creating a virtual nachine

resource "azurerm_virtual_machine" "web-linuxvm" {
  name = "${local.resource_name_prefix}-web-linuxvm"
  resource_group_name = azurerm_resource_group.myRG.name
  location = azurerm_resource_group.myRG.location
  size = "Standard_DS1_v2"
  admin_username = "azureadmin"
  network_interface_ids = [ azurerm_network_interface.web_linuxvm_nic.id ]
  admin_ssh_key {
      username = "azureadmin"
      public_key = file("${path.module}/ssh-key/terraform-azure.pub")
  }

  os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    sku = "83-gen2"
    version = "latest"
  }  
  custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")
  
}