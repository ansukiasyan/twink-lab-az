resource "azurerm_public_ip" "vm32" {
  name                = "vm32"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
  allocation_method   = "Static"
}

output "vm32_public_ip" {
  value = azurerm_public_ip.vm32.ip_address
}

resource "azurerm_network_interface" "vm32" {
  name                = "vm32"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name

  ip_configuration {
    name                          = "vm32"
    subnet_id                     = azurerm_subnet.servers.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(azurerm_subnet.servers.address_prefix, 32)
    public_ip_address_id          = azurerm_public_ip.vm32.id
  }
}

resource "azurerm_virtual_machine" "vm32" {
  name                  = "vm32"
  location              = azurerm_resource_group.prod.location
  resource_group_name   = azurerm_resource_group.prod.name
  network_interface_ids = [azurerm_network_interface.vm32.id]
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
    name              = "vm32_os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "prod-vm32"
    admin_username = "prodadmin"
    custom_data    = file("cloudconfig_ubuntu.yml")
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/prodadmin/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAsQet7FpUFuBylm+JrVxhYkQJlUyeuvxHVLEa3cn37CarrhGmhthr5lSE/2QZnICQ1v+9K1pkznHPJoWhQbFBU4CQ1WzBvcSWjzoPeSgMZm+NT6G+TxK+KuINfVKP5PwxkWYRBBkjTDn404HZYeg4eKo0/j1xQ4JwZIVoqyER/qY/Ipj22ANvnXBVP+vFXXwurb9TnsLnzfc+/eckl7+axtdNTl04npOvo5cZ2RN+g9rth8AZY3pPYq5sjjHyBYssnzyNgri4keXC8Req8XyabfaO6hZ9qrbUjXjCc6OG6AAYk8LxCwI99QAHtWUfd8XblF08vjj+2hMDlxSMKiPEVw== "
    }
  }
}

