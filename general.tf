resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}-${var.region}-dbxsandbox"
  location = var.region

}


resource "azurerm_data_factory" "adf" {
  name                = "adf-${var.environment}-${var.region}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  vsts_configuration {
          account_name       = "devops_account_name_here"
          branch_name        = "Main-AzureDataFactory"
          project_name       = "US Data"
          publishing_enabled = true
          repository_name    = "US Data"
          root_folder        = "/"
          tenant_id          = "tenant_guid_here"
        }

    identity {
        #   identity_ids = []
        #   principal_id = ""
        #   tenant_id    = ""
          type         = "SystemAssigned"
        }
}