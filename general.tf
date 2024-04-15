resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}-${var.region}-dbxsandbox"
  location = var.region

}


