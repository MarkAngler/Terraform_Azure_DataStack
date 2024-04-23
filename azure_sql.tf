resource "azurerm_sql_server" "mssqlserver-d" {
  name                         = "devops-poc-mssqlserver-d"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "saadmin"
  administrator_login_password = "thisIsDog11"


}

resource "azurerm_sql_server" "mssqlserver-q" {
  name                         = "devops-poc-mssqlserver-q"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "saadmin"
  administrator_login_password = "thisIsDog11"


}


resource "azurerm_sql_server" "mssqlserver-r" {
  name                         = "devops-poc-mssqlserver-r"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "saadmin"
  administrator_login_password = "thisIsDog11"


}


resource "azurerm_mssql_database" "mssql-dbexample-d" {
  name           = "example-db-d"
  server_id      = azurerm_mssql_server.mssqlserver-d.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true
  enclave_type   = "VBS"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}