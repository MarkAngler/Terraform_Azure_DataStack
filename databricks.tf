
resource "azurerm_databricks_workspace" "dbx" {
  name                        = "${var.region}-${var.environment}-databricks-workspace"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  sku                         = "premium"
  managed_resource_group_name = "${var.region}-${var.environment}-databricks-workspace-rg"
}
