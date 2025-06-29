data "azurerm_key_vault" "key_vault_ID" {
  name                = "tijori-insiders"
  resource_group_name = "pan-rg-main"
}

data "azurerm_key_vault_secret" "server_username" {
  name         = "server-admin"
  key_vault_id = data.azurerm_key_vault.key_vault_ID.id
}

data "azurerm_key_vault_secret" "server_password" {
  name         = "spassword"
  key_vault_id = data.azurerm_key_vault.key_vault_ID.id
}
