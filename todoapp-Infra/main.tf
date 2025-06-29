# story added in main parent module
# 🚫 Direct push to main branch is now restricted.
# ✅ All changes must go through a Pull Request (PR).
# 🔍 At least 1 approval is required before merging.
# 🛡️ This ensures safer and review-based collaboration.

# अगर चाहो तो Hindi version या informal version भी बना सकता हूँ।

module "rg_mod" {
  source   = "../child_module/azurerm_rg"
  rg_name  = "Anjali-todo-rg"
  location = "West US"
}

module "rg_mod1" {
  source   = "../child_module/azurerm_rg"
  rg_name  = "Anjali-todo-rg1"
  location = "West US"
}
module "vnet_mod" {
  depends_on    = [module.rg_mod]
  source        = "../child_module/azurerm_vnet"
  location      = "West US"
  rg_name       = "Anjali-todo-rg"
  address_space = ["10.0.0.0/16"]
  vnet_name     = "anjali-vnet"
}

module "frontend_subnet" {
  depends_on       = [module.vnet_mod]
  source           = "../child_module/azurerm_subnet"
  subnet_name      = "frontend_subnet"
  address_prefixes = ["10.0.0.0/24"]
  rg_name          = "Anjali-todo-rg"
  vnet_name        = "anjali-vnet"

}

module "pipIP_mod" {
  depends_on = [module.rg_mod]
  source     = "../child_module/azurerm_publicIP"
  pip_name   = "frontend_pip"
  location   = "West US"
  rg_name    = "Anjali-todo-rg"
}

module "vm_mod" {
  depends_on = [module.frontend_subnet]
  source     = "../child_module/azurerm_vm"
  nic_name   = "frontend_nic"
  location   = "West US"
  rg_name    = "Anjali-todo-rg"
  # subnet_id = "/subscriptions/0fb3b41d-23bc-47d2-861e-1582e1789bd5/resourceGroups/Anjali-todo-rg/providers/Microsoft.Network/virtualNetworks/anjali-vnet/subnets/frontend_subnet"
  vm_name = "frontend-vm"
  # username = "frontend"
  # password = "Anjali@12345"
  img_publisher = "Canonical"
  img_offer     = "0001-com-ubuntu-server-focal"
  img_sku       = "20_04-lts"
  # pipID = "/subscriptions/0fb3b41d-23bc-47d2-861e-1582e1789bd5/resourceGroups/Anjali-todo-rg/providers/Microsoft.Network/publicIPAddresses/frontend_pip"

}

module "kv_mod" {
  depends_on = [ module.rg_mod ]
  source   = "../child_module/azurerm_key_vault"
  kv_name  = "sensitive-details"
  location = "West US"
  rg_name  = "Anjali-todo-rg"

}

module "server_mod" {
  depends_on = [ module.rg_mod ]
  source          = "../child_module/azurerm_sql_server"
  sql_server_name = "server-anjali"
  rg_name         = "Anjali-todo-rg"
  location        = "West US"
  # serveradmin = "anjali"
  # serverpassword = "frontend-A@12345"

}

module "db_mod" {
  depends_on   = [module.server_mod]
  source       = "../child_module/azurerm_sql_databse"
  db_name      = "anjali-db"
  # server_id    = "/subscriptions/0fb3b41d-23bc-47d2-861e-1582e1789bd5/resourceGroups/Anjali-todo-rg/providers/Microsoft.Sql/servers/server-anjali"
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
}

module "nsg_mod" {
depends_on = [ module.rg_mod ]
source = "../child_module/azurerm_NSG"
nsg_name = "anjali-nsg"
location = "West US"
rg_name = "Anjali-todo-rg"
}