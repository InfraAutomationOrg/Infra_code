#Get NSG
data "azurerm_network_security_group" "nsg_id" {
  name                = "anjali-nsg"
  resource_group_name = "Anjali-todo-rg"
}

#create NIC
resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet_ID.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.pip_ID.id
  }
}

# Associate NSG to NIC
resource "azurerm_network_interface_security_group_association" "nsg_nic_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = data.azurerm_network_security_group.nsg_id.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = data.azurerm_key_vault_secret.vm_username.value
  admin_password = data.azurerm_key_vault_secret.vm_password.value
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]




  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.img_publisher
    offer     = var.img_offer
    sku       = var.img_sku
    version   = "latest"
  }

  custom_data = base64encode(<<-EOF
	#!/bin/bash
	sudo apt update
	sudo apt install nginx -y
	sudo systemctl enable nginx
	sudo systemctl start nginx

	EOF
)
}

