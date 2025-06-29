resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
  
    name                       = "EnableSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    
    source_address_prefix      = "*"
    source_port_range          = "*"

    destination_port_range     = "80"
    destination_address_prefix = "*"
  }
}