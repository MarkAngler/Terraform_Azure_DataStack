resource "azurerm_storage_account" "storageaccount" {
  name                     = "${var.region}${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled = true

}


resource "azurerm_storage_container" "container_dbx_uc_eastus_metastore" {
  name                  = "dbx-uc-${var.region}-metastore"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "container_datalake" {
  name                  = "datalake-${var.region}"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "azure_role_storage" {
  scope                = azurerm_storage_account.storageaccount.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.dbx_acd.identity[0].principal_id
}