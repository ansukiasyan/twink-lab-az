resource "azurerm_public_ip" "lab_vm21" {
  name                = "lab_vm21"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  allocation_method   = "Static"
}

output "lab_vm21_public_ip" {
  value = azurerm_public_ip.lab_vm21.ip_address
}

resource "azurerm_network_interface" "lab_vm21" {
  name                = "lab_vm21"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "lab_vm21"
    subnet_id                     = azurerm_subnet.srv.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.lab_vm21.id
  }
}

resource "azurerm_virtual_machine" "lab_vm21" {
  name                  = "lab_vm21"
  location              = azurerm_resource_group.lab.location
  resource_group_name   = azurerm_resource_group.lab.name
  network_interface_ids = [azurerm_network_interface.lab_vm21.id]
  vm_size               = "Standard_A2_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.7"
    version   = "latest"
  }
  storage_os_disk {
    name              = "lab_vm21"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = replace("lab_vm21", "_", "-")
    admin_username = local.admin_user
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = local.admin_path
      key_data = local.admin_key_data
    }
  }
}

