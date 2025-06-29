

resource "azurerm_mssql_database" "database" {
  name           = var.db_name
  server_id      = data.azurerm_mssql_server.server_ID.id
  collation      = var.collation
  license_type   = var.license_type
# max_size_gb    = 250
#   read_scale     = true
#   sku_name       = "S0"
#   zone_redundant = true

}
