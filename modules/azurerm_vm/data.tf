
data "azurerm_public_ip" "pip_ID" {
  name                = "frontend_pip"
  resource_group_name = "Anjali-todo-rg"
}

data "azurerm_subnet" "subnet_ID" {
  name                 = "frontend_subnet"
  virtual_network_name = "anjali-vnet"
  resource_group_name  = "Anjali-todo-rg"
}


data "azurerm_key_vault" "key_vault_ID" {
  name                = "tijori-insiders"
  resource_group_name = "pan-rg-main"
}

data "azurerm_key_vault_secret" "vm_username" {
  name         = "vm-username"
  key_vault_id = data.azurerm_key_vault.key_vault_ID.id
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vpassword"
  key_vault_id = data.azurerm_key_vault.key_vault_ID.id
}