resource "azurerm_mssql_server" "mssqlserver-d" {
  name                         = "devops-poc-mssqlserver-d"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = azurerm_key_vault_secret.sql_administrator_login.value
  minimum_tls_version          = "1.2"

#   azuread_administrator {
#     login_username = "AzureAD Admin"
#     object_id      = "00000000-0000-0000-0000-000000000000"
#   }

}

resource "azurerm_mssql_server" "mssqlserver-q" {
  name                         = "devops-poc-mssqlserver-q"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = azurerm_key_vault_secret.sql_administrator_login.value
  minimum_tls_version          = "1.2"

#   azuread_administrator {
#     login_username = "AzureAD Admin"
#     object_id      = "00000000-0000-0000-0000-000000000000"
#   }

}



resource "azurerm_mssql_database" "mssql-dbexample-d" {
  name           = "example-db-d"
  server_id      = azurerm_mssql_server.mssqlserver-d.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
#   max_size_gb    = 4
#   read_scale     = true
  sku_name       = "S0"
#   zone_redundant = true
  enclave_type   = "VBS"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}