resource "azurerm_public_ip" "lab_vm32" {
  name                = "lab_vm32"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  allocation_method   = "Static"
}

output "lab_vm32_public_ip" {
  value = azurerm_public_ip.lab_vm32.ip_address
}

resource "azurerm_network_interface" "lab_vm32" {
  name                = "lab_vm32"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "lab_vm32"
    subnet_id                     = azurerm_subnet.servers.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.lab_vm32.id
  }
}

resource "azurerm_virtual_machine" "lab_vm32" {
  name                  = "lab_vm32"
  location              = azurerm_resource_group.lab.location
  resource_group_name   = azurerm_resource_group.lab.name
  network_interface_ids = [azurerm_network_interface.lab_vm32.id]
  vm_size               = "Standard_A2_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "lab_vm32"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = replace("lab_vm32", "_", "-")
    admin_username = local.admin_user
    custom_data    = file("cloudconfig_ubuntu.yml")
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = local.admin_path
      key_data = local.admin_key_data
    }
  }
}

