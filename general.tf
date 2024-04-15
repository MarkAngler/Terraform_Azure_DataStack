resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}-${var.region}-dbxsandbox"
  location = var.region

}


resource "azurerm_data_factory" "adf" {
  name                = "adf-${var.environment}-${var.region}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}