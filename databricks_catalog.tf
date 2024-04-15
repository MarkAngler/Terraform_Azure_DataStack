resource "azurerm_databricks_access_connector" "dbx_acd" {
  name                = "acd_databricks_${var.environment}_${var.region}_001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  identity {
    type = "SystemAssigned"
  }
}

resource "databricks_metastore" "uc_eastus_metastore" {
  name = "uc_${var.region}_metastore"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
    azurerm_storage_container.dbx_uc_eastus_metastore.name,
    azurerm_storage_account.storageaccount.name)
  owner         = "DataEngineers"
  region        = azurerm_resource_group.rg.location
  force_destroy = true
}

resource "databricks_metastore_assignment" "dbx_metastore_assignment" {
  metastore_id = databricks_metastore.uc_eastus_metastore.id
  workspace_id = azurerm_databricks_workspace.dbx.workspace_id
}



resource "databricks_storage_credential" "dbx_storage_creds" {
  name = "acd_storage_creds_${var.environment}_${var.region}_001"
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.dbx_acd.id
  }
  depends_on = [databricks_metastore_assignment.dbx_metastore_assignment]
}



resource "databricks_catalog" "uc_d_sandbox" {
  name    = "${var.region}_${var.environment}_sandbox"
  comment = ""
  properties = {
    purpose = "dev"
  }
  depends_on = [azurerm_databricks_workspace.dbx, databricks_metastore_assignment.dbx_metastore_assignment]
}


resource "databricks_external_location" "dbx_ext_storage_general" {
  name = "azure_datalake_storage_general"
  url = format("abfss://%s@%s.dfs.core.windows.net",
  azurerm_storage_container.container_datalake.name,
  azurerm_storage_account.storageaccount.name)
  credential_name = databricks_storage_credential.dbx_storage_creds.id
  depends_on = [
    databricks_metastore_assignment.dbx_metastore_assignment
  ]
}