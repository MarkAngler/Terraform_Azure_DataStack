resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}-${var.region}-dbxsandbox"
  location = var.region

}


resource "azurerm_storage_account" "storageaccount" {
  name                     = "${var.region}${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled = true

}


resource "azurerm_storage_container" "container_datalake" {
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
}