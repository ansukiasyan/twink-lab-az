resource "azurerm_network_security_group" "srv" {
  name                = "srv"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  security_rule {
    name                       = "ICMP_ANY"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "ICMP"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = ""
  }
  security_rule {
    name                       = "SSH_ANY"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["2233", "2222", "22"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "RDP_TRUST"
    priority                   = 301
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefixes    = ["178.160.250.112/28", "37.252.68.159"]
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "lab" {
  name                = "lab"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  address_space       = ["10.81.0.0/16"]
}

resource "azurerm_subnet" "srv" {
  name                 = "srv"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name
  address_prefix       = cidrsubnet(azurerm_virtual_network.lab.address_space[0], 8, 10)
}

resource "azurerm_subnet_network_security_group_association" "srv" {
  subnet_id                 = azurerm_subnet.srv.id
  network_security_group_id = azurerm_network_security_group.srv.id
}

